<template>
	<view>
		<image mode="aspectFit" src="../../static/logo.jpg"></image>

		<!-- 		<uni-section title="倒数时间长度(单位秒)" type="line" padding>
			<uni-number-box v-model="countdown"></uni-number-box>
		</uni-section> -->
		<uni-section title="持续时间(单位秒)" type="line" padding>
			<uni-number-box v-model="duration" :min="5" :step="5"></uni-number-box>
		</uni-section>

		<uni-section title="密码框" type="line" padding>
			<uni-easyinput type="password" v-model="passwd" placeholder="请输入密码"></uni-easyinput>
		</uni-section>

		<button class="uni-primary" v-on:click="startgame()" style="width: 100px;margin-top: 20px;">开始游戏</button>

		<button class="uni-error" v-on:click="stopgame()" style="width: 100px;margin-top: 20px;">停止游戏</button>

		<button class="uni-success" v-on:click="toTop()" style="width: 100px;margin-top: 20px;">排行榜</button>

	</view>
</template>

<script>
	export default {
		data() {
			return {
				countdown: 0,
				duration: 30,
				passwd: "",
			}
		},
		methods: {
			toTop() {
				const url = "/pages/top/top";
				uni.navigateTo({
					url: url,
				})
			},

			stopgame() {
				uni.request({
					url: "/api/stopgame",
					method: "post",
					header: {
						'content-type': 'application/json'
					},
					timeout: 500,
					data: {
						passwd: this.passwd,
					},
					success: res => {
						if (res.data.code == 0) {
							uni.showToast({
								"title": "停止成功",
								duration: 2000
							})
						} else {
							uni.showToast({
								"title": res.data.message + "(" + res.data.code + ")",
								duration: 2000
							})
						}
						console.log(23323, res.statusCode, );
						res.data

					},
					fail: res => {
						console.log(2333, res);
					},
				})
			},
			startgame() {
				uni.request({
					url: "/api/creategame",
					method: "post",
					header: {
						'content-type': 'application/json'
					},
					timeout: 500,
					data: {
						countdown: this.countdown,
						duration: this.duration,
						passwd: this.passwd,
					},
					success: res => {
						if (res.data.code == 0) {
							uni.showToast({
								"title": "开始游戏",
								duration: 2000
							})
						} else {
							uni.showToast({
								"title": res.data.message + "(" + res.data.code + ")",
								duration: 2000
							})
						}
						console.log(23323, res.statusCode, );
						res.data

					},
					fail: res => {
						console.log(2333, res);
					},
				})
			}
		}
	}
</script>

<style>

</style>