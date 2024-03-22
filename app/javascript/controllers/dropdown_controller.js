import Dropdown from 'stimulus-dropdown'

export default class extends Dropdown {
  connect() {
    super.connect()
    console.log('Do what you want heres.')
  }

  toggle(event) {
    super.toggle()
  }

  hide(event) {
    super.hide(event)
  }
}