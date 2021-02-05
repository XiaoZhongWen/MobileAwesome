/*
 * @Author: your name
 * @Date: 2021-02-05 11:18:17
 * @LastEditTime: 2021-02-05 13:46:40
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /assassin_reactnative_module/src/features/message/redux/updateMessageTip.js
 */

import {
    MESSAGE_UPDATE_TIP_SUCCESS,
    MESSAGE_UPDATE_TIP_FAILURE,
} from './constants';

import {COMMOM_GROUP} from '../../../common/constants';
import {ContactsDataProvider} from '../../../common/AssassinModules';

export function updateMessageTip(messageList, index) {
    return (dispatch) => {
        const tip = messageList[index];
        const isGroup = tip.senderId.startsWith(COMMOM_GROUP);
        if (isGroup) {
            let promises = [];
            promises.push(ContactsDataProvider.fetchUserInfo(tip.senderId));
            promises.push(ContactsDataProvider.fetchUserInfo(tip.senderId_g));
            Promise.all(promises)
                .then(function (result) {
                    const array = result.map((item) => JSON.parse(item));
                    const headUrl = array[0]?.headUrl ?? '';
                    const nickname = array[1]?.cnname ?? '';
                    tip.headUrl = headUrl;
                    tip.nickname = nickname;
                    dispatch({
                        type: MESSAGE_UPDATE_TIP_SUCCESS,
                        messageList: messageList,
                    });
                })
                .catch(function (reason) {
                    dispatch({
                        type: MESSAGE_UPDATE_TIP_FAILURE,
                    });
                });
        } else {
            ContactsDataProvider.fetchUserInfo(tip.senderId)
                .then(function (result) {
                    const info = JSON.parse(result);
                    const headUrl = info?.headUrl ?? '';
                    const nickname = info?.cnname ?? '';
                    tip.headUrl = headUrl;
                    tip.nickname = nickname;
                    dispatch({
                        type: MESSAGE_UPDATE_TIP_SUCCESS,
                        messageList: messageList,
                    });
                })
                .catch(function (reason) {
                    dispatch({
                        type: MESSAGE_UPDATE_TIP_FAILURE,
                    });
                });
        }
    };
}

export function reducer(state, action) {
    switch (action.type) {
        case MESSAGE_UPDATE_TIP_SUCCESS:
            return {
                ...state,
                messageList: action.messageList,
            };
        case MESSAGE_UPDATE_TIP_FAILURE:
            return {
                ...state,
            };
        default:
            return state;
    }
}
