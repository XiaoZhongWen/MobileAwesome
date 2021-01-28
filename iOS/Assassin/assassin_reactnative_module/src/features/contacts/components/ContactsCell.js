/*
 * @Author: your name
 * @Date: 2021-01-27 17:33:39
 * @LastEditTime: 2021-01-28 16:43:06
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /assassin_reactnative_module/src/features/contacts/components/ContactsCell.js
 */

import React, {Component} from 'react';
import {Text, StyleSheet, View, Image} from 'react-native';
import {COMMON_HEADER_SIZE, COMMOM_MARGIN} from '../../../common/constants';

export default class ContactsCell extends Component {
    render() {
        const {data, size, titleStyle, subtitleStyle} = this.props;
        const headUrl = data.headUrl.length > 0 ? data.headUrl : 'http://about';
        const headerStyle = size
            ? {width: size, height: size, borderRadius: size * 0.5}
            : styles.header;

        return (
            <View style={styles.container}>
                <Image
                    source={{uri: headUrl}}
                    style={headerStyle}
                    defaultSource={require('../../../../img/default_portrait.png')}
                />
                <View style={styles.rightContainer}>
                    <Text style={titleStyle ?? styles.title}>
                        {data.displayName}
                    </Text>
                    <Text style={subtitleStyle ?? styles.username}>
                        {data.username}
                    </Text>
                </View>
            </View>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        flexDirection: 'row',
        margin: COMMOM_MARGIN,
    },
    header: {
        width: COMMON_HEADER_SIZE,
        height: COMMON_HEADER_SIZE,
        borderRadius: COMMON_HEADER_SIZE * 0.5,
    },
    rightContainer: {
        justifyContent: 'space-around',
        marginLeft: COMMOM_MARGIN,
    },
    title: {
        fontSize: 13,
    },
    username: {
        color: '#aaaaaa',
        fontSize: 13,
    },
});
