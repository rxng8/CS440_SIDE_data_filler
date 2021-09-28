import React, { PureComponent, Fragment } from 'react';
import ReactDOM from 'react-dom';

class SelectConditions extends PureComponent {
  state = {
    options: [
      {
        name: 'Select…',
        value: null,
        medicines: [],
      },
      {
        name: 'Allergies',
        value: 'Allergies',
        medicines: ["Allegra", "Benadryl", "Claritin", "Zyrtec"],
      },
      {
        name: 'Asthma',
        value: 'Asthma',
        medicines: ["Alvesco", "Asmanex", "Flovent", "Pulmicort"],
      },
      {
        name: 'Headache',
        value: 'Headache',
        medicines: ["Advil", "Bayer", "Tylenol", "Naproxen"],
      },
      {
        name: 'Stomach Ache',
        value: 'Stomach Ache',
        medicines: ["Alka Seltzer", "GasX", "Tums"],
      },
    ],
    value: '?',
    medicines: ["Select"],
  };

  handleChange = (event) => {

    this.setState({
      value: event.target.value
    }, this.setMedicines);

  };

  setMedicines = () => {
    var condition = this.state.value;
    this.setState(state => {
      const medicines = state.options.find((element) => element.name === condition).medicines;
      return {
        medicines
      };
    });
  }

  render() {
    const { options, value, medicines } = this.state;

    return (
      <Fragment>
        <h1>Medical-Financial Application 3</h1>
        <div>
          <fieldset>
            <legend>General Information</legend>
            <div>
              <form>
                First Name: <input type="text" id="firstName" name="firstname" value=""/> &nbsp;
                Last Name: <input type="text" id="lastName" name="lastname" value=""/>
                <br/>
                <br/>
                Address: <input type="text" id="address" name="address" value=""/> &nbsp;
                City: <input type="text" id="city" name="city" value=""/> &nbsp;
                State: <input type="text" id="state" name="name" value=""/> &nbsp;
                Zip Code: <input type="text" id="zipcode" name="zipcode" value=""/>
                <br/>
                <br/>
                Phone: <input type="text" class="phone" name="phoneFirstPart" value=""/>-<input type="text" class="phone" name="phoneSecondPart" value=""/>-<input type="text" class="phone" name="phoneThirdPart" value=""/> &nbsp;
                Email: <input type="email" name="email" value=""/>
              </form>
              <br/>
            </div>
          </fieldset>
        </div>
        <div>
          <br/>
          <fieldset>
            <legend>Insurance</legend>
            <form>
              Do you have insurance coverage? Select all that apply.
              <br/>
              <input type="checkbox" class="insurance" name="Medicare"/><label for="Medicare">Medicare</label>
              <input type="checkbox" class="insurance" name="Medicare"/><label for="MedicareAdvantage">Medicare Advantage</label>
              <input type="checkbox" class="insurance" name="CommercialInsurance1"/><label for="CommercialInsurance1">Commercial Insurance (Emploter-Sponsored)</label>
              <input type="checkbox" class="insurance" name="CommercialInsurance2"/><label for="CommercialInsurance2">Commercial Insurance (Private or Exchanged/Marketplace)</label>
              <input type="checkbox" class="insurance" name="Medicaid"/><label for="Medicaid">Medicaid</label>
              <input type="checkbox" class="insurance" name="TRICARE"/><label for="TRICARE">TRICARE</label>
            </form>
          </fieldset>
        </div>
        <div>
          <br/>
          <fieldset>
            <legend>Conditions & Medicine</legend>
            <form>
              What condition are you suffering from? Pick one. &nbsp;
              <select onChange={this.handleChange} value={value} data={medicines}>
                {options.map(item => (
                  <option key={item.value} value={item.value}>
                    {item.name}
                  </option>
                ))}
              </select>
              <br/>
              Which medicine do you need? &nbsp;
              <select value={value}>{medicines.map(x => (
                <option key={x} value={x}>{x}</option>
              ))}
              </select>
            </form>
          </fieldset>
        </div>
        <div>
          <br/>
          <fieldset>
            <legend>Time Period</legend>
            How long have you experienced any of the above conditions?
            <br/>
              <input type="radio" name="period" value="never"/> <label for="never">Never</label>
              <input type="radio" name="period" value="lessThLessThanAYearanYear"/> <label for="LessThanAYear">Less than a year</label>
              <input type="radio" name="period" value="OneToTwoYears"/> <label for="OneToTwoYears">One to two years</label>
              <input type="radio" name="period" value="MoreThanTwoYears"/> <label for="MoreThanTwoYears">More than two years</label>
          </fieldset>
        </div>
        <div>
          <br/>
          <fieldset>
              <input type="button" name="clear" value="Clear Form"/>
              <input type="button" name="submit" value="Submit Information" onclick="return validate()"/>
          </fieldset>
        </div>
      </Fragment>
    );
  }
}


// class SelectMedication extends PureComponent {
//     constructor(props) {
//       super(props);
//       this.state = {
//         modules: [
//           {name: 'Allergies', value: ["Allegra", "Benadryl", "Claritin", "Zyrtec"]},
//           {name: 'Asthma', value: ["Alvesco", "Asmanex", "Flovent", "Pulmicort"]},
//           {name: 'Headache', value: ["Advil", "Bayer", "Tylenol", "Naproxen"]},
//           {name: 'Stomach Ache', value: ["Alka Seltzer", "GasX", "Tums"]}
//         ]
//
//       }
//     }
// }

// export default SelectConditions;

ReactDOM.render(<SelectConditions />, window.document.body);
// getElementsByTagName('tagName')
