var UserProfile = Backbone.Model.extend({
    urlRoot: '/api/me'
});

// Edit Profile
var EditProfile = Backbone.View.extend({
    el: '.user-profile',
    render: function() {
        hideError();
        var that = this;
        that.profile = new UserProfile({id: 1}); //TODO: Is there a way not to 'fake' this id?
        that.profile.fetch({
            success: function(profile){
                console.log(profile);
                var template = _.template($('#update-profile').html(), {
                    profile: profile
                });
                that.$el.html(template);
            },
            error: function(model, response) {
                showError($.parseJSON(response.responseText));
            }
        });
    },
    events: {
        'submit .user-profile-form': 'updateProfile'
    },
    updateProfile: function(ev){
        hideError();
        var userDetails = $(ev.currentTarget).serializeObject();
        var profile = new UserProfile();
        profile.save(userDetails, {
            success: function() {
                // TODO: Update username on the top right
                router.navigate('', {trigger: true});
            },
            error: function(model, response) {
                showError($.parseJSON(response.responseText));
            }
        });
        return false;
    }
});

// ROUTER
var Router = Backbone.Router.extend({
    routes : {
        '': 'home'
    }
});

// RUNTIME
var editProfile = new EditProfile();

var router = new Router();

router.on('route:home', function() {
    editProfile.render();
});

Backbone.history.start();