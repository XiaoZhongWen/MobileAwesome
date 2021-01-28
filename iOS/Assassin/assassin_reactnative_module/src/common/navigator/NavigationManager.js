/*
 * @Author: your name
 * @Date: 2021-01-26 12:25:09
 * @LastEditTime: 2021-01-27 11:23:49
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /assassin_reactnative_module/src/common/navigator/NavigationManager.js
 */

import {SystemInterfaceProvider} from '../AssassinModules';
import {COMMON_ROUTENAME_MESSAGE} from '../constants';

class NavigationManager {
    constructor() {
        if (NavigationManager.prototype.Instance === undefined) {
            NavigationManager.prototype.Instance = this;
        }
        return NavigationManager.prototype.Instance;
    }

    set navigation(navigation) {
        this._navigation = navigation;
        this._navigation.addListener('willFocus', (payload) => {
            const isRootRoute =
                payload.state.routeName === COMMON_ROUTENAME_MESSAGE;
            SystemInterfaceProvider.hideTabBar(!isRootRoute);
        });
        this._navigation.addListener('didFocus', (payload) => {});
        this._navigation.addListener('willBlur', (payload) => {
            const isRootRoute =
                payload.state.routeName === COMMON_ROUTENAME_MESSAGE;
            SystemInterfaceProvider.hideTabBar(!isRootRoute);
        });
        this._navigation.addListener('didBlur', (payload) => {});
    }

    push(routeName, params) {
        this._navigation.navigate(routeName, {...params});
    }
}

export default navigationManager = new NavigationManager();
