# react-flux-rails [![Gem Version](https://badge.fury.io/rb/react-flux-rails.svg)](https://badge.fury.io/rb/react-flux-rails) [![Gem Total Downloads](https://img.shields.io/gem/dt/react-flux-rails.svg)](https://rubygems.org/gems/react-flux-rails)

react-flux-rails is a simple flux pattern javascript Gem for using in Rails framework.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'react-flux-rails'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install react-flux-rails

To use react-flux-rails add this require statement to your application.js file:

```ruby
//= require react-flux
```

## API

### flux.createActions()

Action is used inside components and use action to reach a store.

```javascript
var Actions = flux.createActions(['addItem', 'removeItem']);
```

### flux.createStore()

Store use to handle the actions esp store the global variable for using in other components. They will map to handle with the same name.

#### state

Create a store with lists state:

```javascript
var Store = flux.createStore({
  lists: []
});
```

#### actions

Use to list what actions the store should handle. They will map to handle with the same name.

```javascript
var Store = flux.createStore({
  lists: [],
  actions: [
    Actions.addItem
  ]
});
```

#### handler

Based on the name of the action, add a handler that will run when the action is triggered. Any arguments passed to the action will be available in the handler.

```javascript
var Store = flux.createStore({
  lists: [],
  actions: [
    Actions.addItem
  ],
  addItem: function(item) {
    this.lists.push(item);
  }
});
```

#### event

flux-react uses EventEmitter2 which allows for more granular control of events. Instead of always triggering a change event or/and trigger a specific event you will now always trigger a specifically named event. It is recommended to namespace your events related to the state you are changing. In the current example "lists" is the state name and "add" is what we did to that state. That becomes "lists.add". Look at component to see how you can use this to optimize your rendering.

```javascript
var Store = flux.createStore({
  lists: [],
  actions: [
    Actions.addItem
  ],
  addItem: function(item) {
    this.lists.push(item);
    this.emit('lists.add');
  }
});
```

#### exports

Methods defined in exports will be returned by createStore. Components or other parts of the architecture can use it to get state from the store. The methods are bound to the store, meaning "this.lists" points to the state "lists".

**Note:** values returned by an export method will be deep cloned. Meaning that the state of a store is immutable. You can not do changes to a returned value and expect that to be valid inside your store also. You have to trigger an action to change the state of a store.

```javascript
var Store = flux.createStore({
  lists: [],
  actions: [
    Actions.addItem
  ],
  addItem: function(item) {
    this.lists.push(item);
    this.emit('lists.add');
  },
  exports: {
    getLists: function () {
      return this.lists;
    }
  }
});
```

#### listener

```javascript
var ComponentList = React.createClass({
  getInitialState: function () {
    return {
      lists: Store.getLists()
    };
  },
  triggerAction: function() {
    Actions.addItem("Item added"); // Trigger action addItem
  },
  onChange: function () {
    this.setState({
      lists: Store.getLists()
    });
  },
  componentWillMount: function () {
    Store.on('lists.add', this.onChange); // Specific event is triggered from the store
  },
  componentWillUnmount: function () {
    Store.off('lists.add', this.onChange); // Remove any other type of listener
  },
  render: function () {
    return (
      <div>
        <button onClick={this.triggerAction}>Click</button>
        <br/><br/>
        {JSON.stringify(this.state.lists)}
      </div>
    );
  }
});
```

## Example

```javascript
var Actions = flux.createActions(['addItem']);

var Store = flux.createStore({
  lists: [],
  actions: [
    Actions.addItem
  ],
  addItem: function(item) {
    this.lists.push(item);
    this.emit('lists.add');
  },
  exports: {
    getLists: function () {
      return this.lists;
    }
  }
});

var ComponentList = React.createClass({
  getInitialState: function () {
    return {
      lists: Store.getLists()
    };
  },
  triggerAction: function () {
    Actions.addItem("Item added");
  },
  onChange: function () {
    this.setState({
      lists: Store.getLists()
    });
  },
  componentWillMount: function () {
    Store.on('lists.add', this.onChange);
  },
  componentWillUnmount: function () {
    Store.off('lists.add', this.onChange);
  },
  render: function () {
    return (
      <div>
        <button onClick={this.triggerAction}>Click</button>
        <br/><br/>
        {JSON.stringify(this.state.lists)}
      </div>
    );
  }
});

ReactDOM.renderComponent(<ComponentList />, document.body);
```

## More Documentation.

See the [flux-react documentation](https://github.com/christianalfoni/flux-react).

## License

[MIT License](http://www.opensource.org/licenses/mit-license.php)

Copyright (c) 2015, [Christian Alfoni](https://github.com/christianalfoni), [Bunlong VAN](https://github.com/Bunlong) ( Maintainer )
