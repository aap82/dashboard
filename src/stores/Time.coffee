import { extendObservable, action, computed } from 'mobx';
import moment from 'moment';

class Time
  constructor: (period = 1000) ->
    extendObservable @, {
      current: moment()
      tick: action 'tick',  ((newTime = moment()) => @current = newTime)


    }


    @interval = setInterval (() => @tick()), period
  formatTime: (time, format = 'h:mma') ->
    t = moment(time)
    return t.format(format)

time = new Time

export default time