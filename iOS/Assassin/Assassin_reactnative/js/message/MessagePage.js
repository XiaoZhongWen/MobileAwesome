/*
 * @Author: your name
 * @Date: 2021-01-24 19:48:12
 * @LastEditTime: 2021-01-24 19:52:32
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /Assassin_reactnative/js/message/MessagePage.js
 */

import React, {Component} from 'react';
import {Text, StyleSheet, View} from 'react-native';

export default class MessagePage extends Component {
    render() {
        return (
            <View style={styles.container}>
                <Text> {'message page'} </Text>
            </View>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
    },
});
