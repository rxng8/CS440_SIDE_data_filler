import React from 'react';
import ReactDOM from 'react-dom';
import './index2.css';

class Conditions extends React.Component {
  constructor(props){
    super(props)
    this.state = {
      value: null,
    };
    this.handleSelect = this.handleSelect.bind(this);
  }

  handleSelect(event) {
    this.setState({value: event.target.value});
  }

  render() {
    return (
      <div>
        <form>
          <select value={this.state.value} id="conditions" name="conditions" onChange{this.handleSelect}>
            <option value="">-Select-</option>
            <option value="Allergies">Allergies</option>
            <option value="Asthma">Asthma</option>
            <option value="Stomach Ache">Stomach Ache</option>
          </select>
        </form>
      </div>
    );
  }
}

class Form extends React.Component {
  render() {
    return (
      <div className="Form">
        <div className="conditions-segment">
    )
  }
}


ReactDOM.render(
  <Game />,
  document.getElementById('root')
);
