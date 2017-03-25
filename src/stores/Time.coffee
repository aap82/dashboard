import { extendObservable, action, computed } from 'mobx';
import moment from 'moment';

class Time
  constructor: (period = 1000) ->
    extendObservable @, {
      current: moment()
      tick: action 'tick',  ((newTime = moment()) => @current = newTime)


    }


    @interval = setInterval (() => @tick()), period

time = new Time

export default time