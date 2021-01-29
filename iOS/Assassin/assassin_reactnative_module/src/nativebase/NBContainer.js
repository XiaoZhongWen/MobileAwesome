/*
 * @Author: your name
 * @Date: 2021-01-29 10:28:22
 * @LastEditTime: 2021-01-29 10:42:08
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /assassin_reactnative_module/src/nativebase/NBContainer.js
 */

import React, {Component} from 'react';
import {Text, StyleSheet, View, TouchableOpacity} from 'react-native';
import {COMMON_THEME_COLOR} from '../common/constants';

export default class NBContainer extends Component {
    render() {
        const {title, onClick} = this.props;
        return (
            <TouchableOpacity onPress={() => onClick(title)}>
                <View style={styles.container}>
                    <Text style={styles.text}>{title}</Text>
                </View>
            </TouchableOpacity>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        backgroundColor: COMMON_THEME_COLOR,
        borderRadius: 5,
        padding: 10,
        width: 100,
        justifyContent: 'center',
        alignItems: 'center',
    },
    text: {
        fontSize: 14.0,
        color: 'white',
    },
});
