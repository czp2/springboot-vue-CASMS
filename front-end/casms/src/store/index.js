import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
    state: {
        // token: JSON.parse(sessionStorage.getItem('token')),
        userInfo: JSON.parse(sessionStorage.getItem('userInfo'))
    },
    mutations: {
        SET_USERINFO: (state, userInfo) => {
            state.userInfo = userInfo
            sessionStorage.setItem('userInfo', JSON.stringify(userInfo))
        },
        REMOVE_USERINFO: (state) => {
            state.userInfo = {}
            sessionStorage.setItem('userInfo', JSON.stringify(''))
        },
        // SET_TOKEN: (state, token) => {
        //     state.token = token
        //     sessionStorage.setItem('token', JSON.stringify(token))
        // },
        // REMOVE_TOKEN: (state) => {
        //     state.token = {}
        //     sessionStorage.setItem('token', JSON.stringify(''))
        // }
    },
    getters: {
        getUser: state => {
            return state.userInfo
        },
        getUserId: state => {
            return state.userInfo.userId
        },
        // getToken: state => {
        //     return state.token
        // }
    },
    actions: {
    },
    modules: {
    }
})
