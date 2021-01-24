/*
 * @Author: your name
 * @Date: 2021-01-19 21:50:32
 * @LastEditTime: 2021-01-19 22:14:13
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /Github_RN/js/navigator/NavigationUtil.js
 */

export default class NavigationUtil {
    static resetToHomePage(params) {
        const {navigation} = params;
        navigation.navigate('Main');
    }
}
