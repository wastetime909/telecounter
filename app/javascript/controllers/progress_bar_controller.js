import { Controller } from "stimulus"
import consumer from '../channels/consumer'

export default class extends Controller {
    static targets = ['progress_bar']

    initialize() {
        console.log('channel subscribed');
        var counter = this.progress_barTarget
        consumer.subscriptions.create({ channel: 'ProgressChannel', id: this.progress_bar_id() }, {
            received(data) {
                counter.innerHTML = data;
            }
        })
    }

    progress_bar_id() {
        return this.progress_barTarget.getAttribute('id')
    }
}
