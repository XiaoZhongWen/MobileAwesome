/*
 * @Author: your name
 * @Date: 2021-02-07 09:54:51
 * @LastEditTime: 2021-02-07 10:32:04
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /assassin_reactnative_module/src/features/message/redux/fetchConversation.js
 */

import {MessageDataProvider} from '../../../common/AssassinModules';
import {
    MESSAGE_FETCH_LASTEST_CONVERSATION_SUCCESS,
    MESSAGE_FETCH_LASTEST_CONVERSATION_FAILURE,
} from './constants';

export function fetchLastestConversation(userId) {
    return (dispatch) => {
        MessageDataProvider.fetchLastestConversation(userId)
            .then(function (result) {
                const conversationList = result.map((item) => JSON.parse(item));
                dispatch({
                    type: MESSAGE_FETCH_LASTEST_CONVERSATION_SUCCESS,
                    conversationList: conversationList,
                });
            })
            .catch(function (error) {
                dispatch({
                    type: MESSAGE_FETCH_LASTEST_CONVERSATION_FAILURE,
                });
            });
    };
}

export function reducer(state, action) {
    switch (action.type) {
        case MESSAGE_FETCH_LASTEST_CONVERSATION_SUCCESS:
            return {
                ...state,
                conversationList: action.conversationList,
            };
        case MESSAGE_FETCH_LASTEST_CONVERSATION_FAILURE:
            return {
                ...state,
            };
        default: {
            return {
                ...state,
            };
        }
    }
}
