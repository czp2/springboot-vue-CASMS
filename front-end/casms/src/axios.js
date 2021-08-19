// import axios from 'axios'
//
// axios.defaults.baseURL = 'http://localhost:8080'
//
// // 前置拦截
// axios.interceptors.request.use(config => {
//   const token = store.getters.getToken
//   if (token != null) {
//     if (config.headers.Authorization == null) {
//       config.headers.Authorization = 'Bearer ' + token
//     }
//   }
//   return config
// })
//
// axios.interceptors.response.use(response => {
//   const res = response.data
//   if (res.code === 200 || res.access_token != null) {
//     return response
//   } else {
//     Element.Message.error(res.msg, { duration: 3 * 1000 })
//     return Promise.reject(response.data.msg)
//   }
// },
// error => {
//   if (error.response.data) {
//     error.message = error.response.data.msg
//     if (error.response.status === 401) {
//       store.commit('REMOVE_USERINFO')
//       router.push('/login')
//     } else {
//       if (error.message != null) {
//         Element.Message.error(error.message, { duration: 3 * 1000 })
//       } else {
//         Element.Message.error(error.response.data.error_description, { duration: 3 * 1000 })
//       }
//     }
//   } else {
//     Element.Message.error('未知异常', { duration: 3 * 1000 })
//   }
//   return Promise.reject(error)
// }
// )
