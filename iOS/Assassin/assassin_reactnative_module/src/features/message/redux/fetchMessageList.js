/*
 * @Author: your name
 * @Date: 2021-02-04 15:51:08
 * @LastEditTime: 2021-02-05 11:18:39
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /assassin_reactnative_module/src/features/message/redux/fetchMessageList.js
 */

import {MessageDataProvider} from '../../../common/AssassinModules';
import {
    MESSAGE_FETCH_LIST_SUCCESS,
    MESSAGE_FETCH_LIST_FAILURE,
} from './constants';

export function fetchMessageList() {
    return (dispatch) => {
        MessageDataProvider.fetchMessageList().then(
            function (result) {
                const messageList = result.map((item) => JSON.parse(item));
                dispatch({
                    type: MESSAGE_FETCH_LIST_SUCCESS,
                    messageList: messageList,
                });
            },
            function (error) {
                dispatch({
                    type: MESSAGE_FETCH_LIST_FAILURE,
                    fetchMessageListError: error,
                });
            },
        );
    };
}

export function reducer(state, action) {
    switch (action.type) {
        case MESSAGE_FETCH_LIST_SUCCESS:
            return {
                ...state,
                messageList: action.messageList,
            };
        case MESSAGE_FETCH_LIST_FAILURE:
            return {
                ...state,
                fetchMessageListError: action.fetchMessageListError,
            };
        default:
            return state;
    }
}
