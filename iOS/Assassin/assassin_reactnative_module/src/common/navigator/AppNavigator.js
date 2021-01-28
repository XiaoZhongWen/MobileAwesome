/*
 * @Author: your name
 * @Date: 2021-01-26 12:24:37
 * @LastEditTime: 2021-01-28 15:51:23
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /assassin_reactnative_module/src/common/navigator/AppNavigator.js
 */

import {createAppContainer, withNavigationFocus} from 'react-navigation';
import {createStackNavigator} from 'react-navigation-stack';
import MessagePage from '../../features/message/MessagePage';
import ContactsPage from '../../features/contacts/ContactsPage';
import withProvider from '../../withProvider';
import {COMMON_THEME_COLOR, COMMON_TITLE_COLOR} from '../constants';
import ContactsDetailPage from '../../features/contacts/ContactsDetailPage';

const NavigationStack = createStackNavigator(
    {
        Message: withNavigationFocus(MessagePage),
        Contacts: ContactsPage,
        ContactsDetail: ContactsDetailPage,
    },
    {
        initialRouteName: 'Message',
        defaultNavigationOptions: {
            headerStyle: {
                backgroundColor: COMMON_THEME_COLOR,
            },
            headerTintColor: COMMON_TITLE_COLOR,
        },
    },
);

const AppNavigator = createAppContainer(NavigationStack);
export default withProvider(AppNavigator);
