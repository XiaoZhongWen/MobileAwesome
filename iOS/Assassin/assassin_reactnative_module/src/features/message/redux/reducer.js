/*
 * @Author: your name
 * @Date: 2021-02-04 16:05:37
 * @LastEditTime: 2021-02-05 13:49:28
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /assassin_reactnative_module/src/features/message/redux/reducer.js
 */

import initialState from './initialState';
import {reducer as fetchMessageListReducer} from './fetchMessageList';
import {reducer as updateMessageTipReducer} from './updateMessageTip';

const reducers = [fetchMessageListReducer, updateMessageTipReducer];

export default function reducer(state = initialState, action) {
    let newState;
    switch (action.type) {
        // Handle cross-topic actions here
        default:
            newState = state;
            break;
    }
    return reducers.reduce((s, r) => r(s, action), newState);
}
