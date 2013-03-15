var source_url = source_url || '';

// OBJECTS COLLECTION AND MODEL
var Things = Backbone.Collection.extend({
    url: '/api/' + source_url
});

var Thing = Backbone.Model.extend({
    urlRoot: '/api/' + source_url
});

// Display all things
var ThingList = Backbone.View.extend({
    el: '.things',
    render: function() {
        var that = this;
        var things = new Things();
        things.fetch({
            success: function (things) {
                var template = _.template($('#thing-list-template').html(), {
                    things: things.models
                });
                that.$el.html(template);
            },
            error: function(model, response) {
                showError($.parseJSON(response.responseText));
            }
        });
    }
});

// Edit things
var EditThing = Backbone.View.extend({
    el: '.things',
    render: function(options) {
        hideError();
        if (options.id)
        {
            var that = this;
            //Edit existing
            that.thing = new Thing({id: options.id});
            that.thing.fetch({
                success: function(thing){
                    var template = _.template($('#edit-thing-template').html(), {
                        thing: thing
                    });
                    that.$el.html(template);
                },
                error: function(model, response) {
                    showError($.parseJSON(response.responseText));
                }
            });
        } else {
            // Create a new one
            var template = _.template($('#edit-thing-template').html(), {
                thing: null
            });
            this.$el.html(template);
        }
    },
    events: {
        'submit .edit-thing-form': 'saveThing',
        'click .delete': 'deleteThing'
    },
    saveThing: function(ev){
        hideError();
        var thingDetails = $(ev.currentTarget).serializeObject();
        var thing = new Thing();
        thing.save(thingDetails, {
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
    deleteThing: function(ev){
        hideError();
        this.thing.destroy({
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
        'new': 'editThing',
        'edit/:id': 'editThing'
    }
});

// Runtime, page load...

var thingList = new ThingList();
var editThing = new EditThing();

var router = new Router();
router.on('route:home', function() {
    thingList.render();
});
router.on('route:editThing', function(id) {
    editThing.render({id: id});
});

// Route the initial URL
Backbone.history.start();
