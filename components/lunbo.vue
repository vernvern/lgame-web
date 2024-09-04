<template>
	<view class="container">
			<liu-super-slide :swiperList="swiperList"  :autoplay="autoplay" :interval="interval"
				@change="change" @click="click"></liu-super-slide>
	</view>
</template>

<script>

	export default {

		data() {
			return {
				autoplay: true,
				interval: 3000,
				 swiperList: [{
					picUrl:'/static/xie/1.jpg',
					title: "",
				},{
					picUrl:'/static/xie/2.jpg',
					title: "",
				}]

			}
		},
		methods: {
			        change(e) {
			                //console.log('当前轮播信息：', e)
			            },
			            //点击轮播
			            click(e) {
			                // console.log('点击轮播', e)
			            }
		}
	}
</script>

<style>

</style>