/*
 * @Author: your name
 * @Date: 2021-01-19 21:55:46
 * @LastEditTime: 2021-01-19 21:57:28
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /Github_RN/js/pages/TrendingPage.js
 */

import React, {Component} from 'react';
import {Text, StyleSheet, View} from 'react-native';

export default class TrendingPage extends Component {
    render() {
        return (
            <View style={styles.container}>
                <Text> TrendingPage </Text>
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
