var UserProfile = Backbone.Model.extend({
    urlRoot: '/api/me'
});

// Edit Profile
var EditProfile = Backbone.View.extend({
    el: '.user-profile',
    render: function(options) {
        hideError();
        var that = this;
        that.profile = new UserProfile({id: 1}); //TODO: Is there a way not to 'fake' this id?
        that.profile.fetch({
            success: function(profile){
                var element = options.property == 'password' ? '#change-password' : '#update-profile';
                var template = _.template($(element).html(), {
                    property: options.property,
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
        'submit .user-profile-form': 'updateProfile',
        'submit .change-password-form': 'updatePassword'
    },
    updateProfile: function(ev){
        hideError();
        var userDetails = $(ev.currentTarget).serializeObject();
        var profile = new UserProfile();
        profile.save(userDetails, {
            success: function(model, response) {
                // Update user display name in top-right
                $('#dropdown-title').html(userDetails.displayName + '<b class="caret"></b>');
                showSuccess(response);
            },
            error: function(model, response) {
                showError($.parseJSON(response.responseText));
            }
        });
        return false;
    },
    updatePassword: function(ev){
        hideError();
        var userDetails = $(ev.currentTarget).serializeObject();
        var profile = new UserProfile();
        profile.save(userDetails, {
            success: function(model, response) {
                showSuccess(response);
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
        '' : 'editProfile',
        ':property': 'editProfile'
    }
});

// RUNTIME
var editProfile = new EditProfile();

var router = new Router();

router.on('route:editProfile', function(property) {
    editProfile.render({property: property});
});

Backbone.history.start();