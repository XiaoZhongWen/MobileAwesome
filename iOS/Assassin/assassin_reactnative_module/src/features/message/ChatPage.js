/*
 * @Author: your name
 * @Date: 2021-02-05 15:00:11
 * @LastEditTime: 2021-02-05 15:49:32
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /assassin_reactnative_module/src/features/message/ChatPage.js
 */

import React, {Component} from 'react';
import {Text, StyleSheet, View} from 'react-native';
import {KEY_CHAT} from './redux/constants';

export default class ChatPage extends Component {
    static navigationOptions = ({navigation}) => {
        const {nickname} = navigation.getParam(KEY_CHAT, '');
        return {
            title: nickname,
        };
    };
    render() {
        const {navigation} = this.props;
        const {nickname} = navigation.getParam(KEY_CHAT, '');
        return (
            <View>
                <Text> textInComponent </Text>
            </View>
        );
    }
}

const styles = StyleSheet.create({});
