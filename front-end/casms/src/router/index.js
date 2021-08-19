import Vue from "vue"
import VueRouter from "vue-router"

import Index from '@/views/login/Index'
import Login from "@/views/login/Login";
import AdminLogin from "@/views/login/AdminLogin";
import Register from "@/views/login/Register";
import NotFound from "@/views/error-page/NotFound"

import AdminDashboard from "@/views/dashboard/admin/AdminDashboard"
import Review from "@/views/manage/Review";
import roleReview from "@/views/manage/review/RoleReview";
import repairReview from "@/views/manage/review/RepairReview";
import problemReview from "@/views/manage/review/ProblemReview";
import Echarts from "@/views/manage/Echarts";
import echartsTest from "@/views/manage/echarts/echartsTest";
import ProblemManage from "@/views/manage/ProblemManage";
import RepairManage from "@/views/manage/RepairManage";
import UserManage from "@/views/manage/UserManage";
import FeedbackManage from "@/views/manage/FeedbackManage";

import UserDashboard from "@/views/dashboard/user/UserDashboard";
import Personnal from "@/views/dashboard/Personnal";
import PersonalInfo from "@/views/userInterface/PersonalInfo";
import MyProblem from "@/views/userInterface/MyProblem";
import MyRepairOrder from "@/views/userInterface/MyRepairOrder";
import HomePage from "@/views/userInterface/HomePage";
import Feedback from "@/views/userInterface/Feedback";

import RepairmanDashboard from "@/views/dashboard/repairman/RepairmanDashboard";
import WorkArea from "@/views/repairmanInterface/WorkArea";
import NewOrders from "@/views/repairmanInterface/orderTable/NewOrders";
import ReceivedOrders from "@/views/repairmanInterface/orderTable/ReceivedOrders";
import ProcessedOrders from "@/views/repairmanInterface/orderTable/ProcessedOrders";
import CompletedOrders from "@/views/repairmanInterface/orderTable/CompletedOrders";

Vue.use(VueRouter);

// 解决重复点击路由报错的BUG
const originalPush = VueRouter.prototype.push
VueRouter.prototype.push = function push(location) {
    return originalPush.call(this, location).catch((err) => err)
}

export default new VueRouter({
    mode: 'history',
    routes: [
        {path: '/', component: Login},
        {path: '/login', component: Login,},
        {path: '/adminLogin', component: AdminLogin,},
        {path: '/register', component: Register,},
        {
            path: '/dashboard/admin', component: AdminDashboard,
            children: [
                {
                    path: '/manage/review', component: Review,
                    children: [
                        {path: '/review/problemReview', component: problemReview},
                        {path: '/review/repairReview', component: repairReview},
                        {path: '/review/roleReview', component: roleReview},
                    ]
                },
                {
                    path: '/manage/echarts', component: Echarts,
                    children: [
                        {path: '/echarts/test',component: echartsTest}
                    ]
                },
                {path: '/manage/user', component: UserManage},
                {path: '/manage/problem', component: ProblemManage},
                {path: '/manage/repair', component: RepairManage},
                {path: '/manage/feedbackManage', component: FeedbackManage},
            ]
        }, {
            path: '/dashboard/user', component: UserDashboard,
            children: [
                {path: '/userInterface/homePage', component: HomePage,},
            ]
        },
        {
            path: '/personal', component:Personnal,
            children: [
                {path: '/personal/personalInfo', component: PersonalInfo},
                {path: '/personal/myProblem', component: MyProblem},
                {path: '/personal/myRepairOrder', component: MyRepairOrder},
                {path: '/personal/feedback', component: Feedback,},
            ]
        },
        {
            path: '/dashboard/repairman', component: RepairmanDashboard,
            children: [
                {path: '/repairmanInterface/myProblem', component: MyProblem},
                {path: '/repairmanInterface/myRepairOrder', component: MyRepairOrder},
                {path: '/repairmanInterface/homePage', component: HomePage,},
                {path: '/repairmanInterface/Feedback', component: Feedback,},
                {
                    path: '/repairmanInterface/workArea', component: WorkArea,
                    children: [
                        {path: '/workArea/newOrders', component: NewOrders},
                        {path: '/workArea/receivedOrders', component: ReceivedOrders},
                        {path: '/workArea/processedOrders', component: ProcessedOrders,},
                        {path: '/workArea/completedOrders', component: CompletedOrders},
                    ]
                },
            ]
        },
        {path: '*', component: NotFound}
    ]
});
