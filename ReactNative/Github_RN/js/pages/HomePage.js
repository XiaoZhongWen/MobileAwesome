/*
 * @Author: your name
 * @Date: 2021-01-19 21:34:50
 * @LastEditTime: 2021-01-20 23:11:20
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /Github_RN/js/pages/HomePage.js
 */

import React, {Component} from 'react';
import {Text, StyleSheet, View} from 'react-native';
import {createAppContainer} from 'react-navigation';
import {createBottomTabNavigator} from 'react-navigation-tabs';
import Ionicons from 'react-native-vector-icons/Ionicons';
import MaterialIcons from 'react-native-vector-icons/MaterialIcons';
import Entypo from 'react-native-vector-icons/Entypo';
import FavoritePage from './FavoritePage';
import MyPage from './MyPage';
import PopularPage from './PopularPage';
import TrendingPage from './TrendingPage';

export default class HomePage extends Component {
    _tabNavigator() {
        const tabNavigator = createBottomTabNavigator(
            {
                popular: {
                    screen: PopularPage,
                    navigationOptions: {
                        title: '最热',
                        tabBarIcon: ({tintColor, focused}) => {
                            return (
                                <MaterialIcons
                                    name={'whatshot'}
                                    size={26}
                                    style={{color: tintColor}}
                                />
                            );
                        },
                    },
                },
                trending: {
                    screen: TrendingPage,
                    navigationOptions: {
                        title: '趋势',
                        tabBarIcon: ({tintColor, focused}) => {
                            return (
                                <Ionicons
                                    name={'md-trending-up'}
                                    size={26}
                                    style={{color: tintColor}}
                                />
                            );
                        },
                    },
                },
                favorite: {
                    screen: FavoritePage,
                    navigationOptions: {
                        title: '收藏',
                        tabBarIcon: ({tintColor, focused}) => {
                            return (
                                <MaterialIcons
                                    name={'favorite'}
                                    size={26}
                                    style={{color: tintColor}}
                                />
                            );
                        },
                    },
                },
                mypage: {
                    screen: MyPage,
                    navigationOptions: {
                        title: '我的',
                        tabBarIcon: ({tintColor, focused}) => {
                            return (
                                <Entypo
                                    name={'user'}
                                    size={26}
                                    style={{color: tintColor}}
                                />
                            );
                        },
                    },
                },
            },
            {
                // tabBarComponent
            },
        );
        return createAppContainer(tabNavigator);
    }

    render() {
        const TabNavigator = this._tabNavigator();
        return <TabNavigator />;
    }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
    },
});
