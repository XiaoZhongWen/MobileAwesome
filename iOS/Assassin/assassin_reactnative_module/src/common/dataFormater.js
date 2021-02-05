/*
 * @Author: your name
 * @Date: 2021-02-05 14:02:27
 * @LastEditTime: 2021-02-05 14:28:57
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /assassin_reactnative_module/src/common/dataFormater.js
 */

export function format(timestamp) {
    const now = new Date();
    const date = new Date(timestamp);

    const now_day = now.getDay();
    const now_month = now.getMonth() + 1;
    const now_year = now.getFullYear();
    const day = date.getDay();
    const month = date.getMonth() + 1;
    const year = date.getFullYear();

    if (now_year === year && now_month === month && now_day === day) {
        return date.getHours + ':' + date.getMinutes;
    }

    if (now_year === year && now_month === month) {
        if (now_day - day === 1) {
            return '昨天';
        } else {
            return month + '月' + day + '日';
        }
    }

    if (now_year === year) {
        return month + '月' + day + '日';
    } else {
        return year + '年' + month + '月' + day + '日';
    }
}
