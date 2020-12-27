
import { Controller } from "stimulus"   
import consumer from '../channels/consumer' 


export default class extends Controller {
    static targets = ["head_counters"]

    initialize(){
        var head_counters = this.head_countersTarget 
        consumer.subscriptions.create({ channel: 'HeadCounters', id: this.head_counter_id()}, {
            received(data){
                // head_counters.innerHTML += data;
                console.log(data);
            }
        })
    }

    head_counter_id(){
        return this.head_countersTarget.getAttribute('id')
    }

    // initialize(){
    //     console.log('yolo and yolo');
    // }
}
