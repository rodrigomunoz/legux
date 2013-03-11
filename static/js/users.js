// USERS COLLECTION AND MODEL
var Users = Backbone.Collection.extend({
    url: '/api/users'
});

var User = Backbone.Model.extend({
    urlRoot: '/api/users'
});

var UserTypes = Backbone.Collection.extend({
    url: '/api/usertypes'
});

// Display all users
var UserList = Backbone.View.extend({
    el: '.users',
    render: function() {
        var that = this;
        var users = new Users();
        users.fetch({
            success: function (users) {
                var template = _.template($('#user-list-template').html(), {
                    users: users.models,
                    userTypes: _.first(userTypes.models) //TODO: Better way to do it? Doing it 3 times
                });
                that.$el.html(template);
            },
            error: function(model, response) {
                showError($.parseJSON(response.responseText));
            }
        });
    }
});

// Edit users
var EditUser = Backbone.View.extend({
    el: '.users',
    render: function(options) {
        hideError();
        if (options.id)
        {
            var that = this;
            //Edit existing
            that.user = new User({id: options.id});
            that.user.fetch({
                success: function(user){
                    var template = _.template($('#edit-user-template').html(), {
                        user: user,
                        userTypes: _.first(userTypes.models)
                    });
                    that.$el.html(template);
                    // Populate default value for dropdown
                    var userType = user.get('type');
                    $('select option[value='+userType+']').attr("selected",true);
                },
                error: function(model, response) {
                    showError($.parseJSON(response.responseText));
                }
            });
        } else {
            // Create a new one
            var template = _.template($('#edit-user-template').html(), {
                user: null,
                userTypes: _.first(userTypes.models)
            });
            this.$el.html(template);
        }
    },
    events: {
        'submit .edit-user-form': 'saveUser',
        'click .delete': 'deleteUser'
    },
    saveUser: function(ev){
        hideError();
        var userDetails = $(ev.currentTarget).serializeObject();
        var user = new User();
        user.save(userDetails, {
            success: function(model, response) {
                showSuccess(response);
                router.navigate('', {trigger: true});
            },
            error: function(model, response) {
                showError($.parseJSON(response.responseText));
            }
        });
        return false;
    },
    deleteUser: function(ev){
        hideError();
        this.user.destroy({
            success: function(model, response) {
                showSuccess(response);
                router.navigate('', {trigger: true});
            },
            error: function(model, response) {
                showError($.parseJSON(response.responseText));
            }
        });
    }
});

// ROUTER
var Router = Backbone.Router.extend({
    routes : {
        '': 'home',
        'new': 'editUser',
        'edit/:id': 'editUser'
    }
});

// Runtime, page load...

var userList = new UserList();
var editUser = new EditUser();
var userTypes = new UserTypes();
var router;

// Start the routes just after downloading the 'UserTypes'
// which are required to render the grid and forms
userTypes.fetch({
    success: function() {
        router = new Router();
        router.on('route:home', function() {
            userList.render();
        });
        router.on('route:editUser', function(id) {
            editUser.render({id: id});
        });

        // Route the initial URL
        Backbone.history.start();
    }
})
