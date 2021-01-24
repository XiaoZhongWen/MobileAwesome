/*
 * @Author: your name
 * @Date: 2021-01-19 07:16:32
 * @LastEditTime: 2021-01-19 21:53:30
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /Github_RN/js/pages/WelcomePage.js
 */

import React, {Component} from 'react';
import {Text, StyleSheet, View} from 'react-native';
import NavigationUtil from '../navigator/NavigationUtil';

export default class WelcomePage extends Component {
    componentDidMount() {
        this.timer = setTimeout(() => {
            NavigationUtil.resetToHomePage(this.props);
        }, 200);
    }

    componentWillUnmount() {
        this.timer && clearTimeout(self.timer);
    }

    render() {
        return (
            <View style={styles.container}>
                <Text> welcome page </Text>
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
