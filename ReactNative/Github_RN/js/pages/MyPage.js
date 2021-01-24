/*
 * @Author: your name
 * @Date: 2021-01-19 21:56:26
 * @LastEditTime: 2021-01-19 21:57:12
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /Github_RN/js/pages/MyPage.js
 */

import React, {Component} from 'react';
import {Text, StyleSheet, View} from 'react-native';

export default class MyPage extends Component {
    render() {
        return (
            <View style={styles.container}>
                <Text> MyPage </Text>
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
