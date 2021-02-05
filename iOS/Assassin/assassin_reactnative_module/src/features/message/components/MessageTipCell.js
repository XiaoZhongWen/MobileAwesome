/*
 * @Author: your name
 * @Date: 2021-02-05 09:19:21
 * @LastEditTime: 2021-02-05 15:40:31
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /assassin_reactnative_module/src/features/message/components/MessageTipCell.js
 */

import React, {Component} from 'react';
import {Text, StyleSheet, View, Image, TouchableOpacity} from 'react-native';
import {
    COMMON_HEADER_SIZE,
    COMMOM_MARGIN,
    COMMON_FONT_SIZE_LEVEL_1,
    COMMON_FONT_SIZE_LEVEL_2,
    COMMON_FONT_SIZE_LEVEL_4,
    COMMON_FONT_WEIGHT_LEVEL_1,
    COMMON_FONT_WEIGHT_LEVEL_2,
    COMMON_ROUTENAME_CHAT,
    COMMOM_GROUP,
} from '../../../common/constants';
import {KEY_CHAT} from '../redux/constants';

import {format} from '../../../common/dataFormater';
import navigationManager from '../../../common/navigator/NavigationManager';

export default class MessageTipCell extends Component {
    render() {
        const {messageTip} = this.props;
        const isGroup = messageTip.senderId.startsWith(COMMOM_GROUP);
        return (
            <TouchableOpacity
                onPress={() => {
                    navigationManager.push(COMMON_ROUTENAME_CHAT, {
                        KEY_CHAT: {
                            userId: messageTip.senderId,
                            nickname: isGroup
                                ? messageTip.groupName
                                : messageTip.nickname,
                        },
                    });
                }}>
                <View style={styles.container}>
                    {/* left */}
                    <Image
                        source={{uri: messageTip.headUrl ?? ''}}
                        style={styles.header}
                        defaultSource={
                            isGroup
                                ? require('../../../../img/group.png')
                                : require('../../../../img/default_portrait.png')
                        }
                    />
                    {/* right */}
                    <View style={styles.rightContainer}>
                        {/* top */}
                        <View style={styles.top}>
                            {/* left */}
                            <Text style={styles.nickname}>
                                {isGroup
                                    ? messageTip.groupName
                                    : messageTip.nickname ?? ''}
                            </Text>
                            {/* right */}
                            <Text style={styles.date}>
                                {format(messageTip.receiveTimestamp * 1000)}
                            </Text>
                        </View>
                        {/* bottom */}
                        <View style={styles.bottom}>
                            <Text
                                style={styles.tip}
                                numberOfLines={1}
                                lineBreakMode={'tail'}>
                                {isGroup
                                    ? messageTip.nickname +
                                          ': ' +
                                          messageTip.messageContent ?? ''
                                    : messageTip.messageContent ?? ''}
                            </Text>
                        </View>
                    </View>
                </View>
            </TouchableOpacity>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        flexDirection: 'row',
        alignItems: 'center',
        paddingVertical: 2,
    },
    header: {
        width: COMMON_HEADER_SIZE,
        height: COMMON_HEADER_SIZE,
        borderRadius: COMMON_HEADER_SIZE * 0.5,
    },
    rightContainer: {
        flex: 1,
        marginLeft: COMMOM_MARGIN,
        justifyContent: 'space-evenly',
        height: 55,
    },
    top: {
        flexDirection: 'row',
        justifyContent: 'space-between',
    },
    bottom: {
        flexDirection: 'row',
        justifyContent: 'space-between',
    },
    nickname: {
        fontSize: COMMON_FONT_SIZE_LEVEL_4,
        fontWeight: COMMON_FONT_WEIGHT_LEVEL_1,
    },
    tip: {
        fontSize: COMMON_FONT_SIZE_LEVEL_2,
        fontWeight: COMMON_FONT_WEIGHT_LEVEL_2,
        color: 'gray',
    },
    date: {
        fontSize: COMMON_FONT_SIZE_LEVEL_1,
        color: 'gray',
    },
});
