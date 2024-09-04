<template>
	<view>
		<view>
			<!-- <lunbo></lunbo> -->
			<!-- 	<view class="imgcontainer">
				<image mode="scaleToFill" src="../../static/1.jpg"></image>
			</view> -->
			<uni-section title="用户名" subTitle="最后排名显示的名字" type="line" padding>

				<uni-easyinput disabled v-model="name" focus @input="input"></uni-easyinput>

			</uni-section>
		</view>

		<view class="imgcontainer">
			<image v-if="startRun" src="../../static/run.gif"></image>
		</view>

		<view class="msg">
			<text v-if="startRun" style="font-size:30px;margin-bottom: 30px;">剩余时间: {{durationstr}} 秒</text>
			<text style="font-size:30px;margin-bottom: 30px;">{{msg}}</text>
			<button v-if="startRun" v-on:click="runClick()" style="width: 300px;font-size: 30px;"> 跑</button>
			<button v-if="topBtn" v-on:click="toTop()" style="width: 300px;"> 排行榜</button>
		</view>


	</view>



</template>

<script>
	//import lunbo from '@/components/lunbo.vue';
	let timer = null;

	let times = 0;
	let gameid = 0;
	let duration = 0;

	export default {
		// components: {
		// 	lunbo,
		// },
		onLoad(option) {
			this.name = option.name
			this.times = 0
		},

		data() {
			return {
				name: "",
				msg: "等待开始...",
				durationstr: "",

				startRun: false, //隐藏按钮
				topBtn: false,
			}
		},
		beforeUnmount() {
			this.clearInterval();
		},
		onBackPress() {
			this.clearInterval();
		},
		mounted() {
			gameid = 0
			duration = 0
			times = 0
			this.onSetInterval()
		},
		methods: {
			toTop() {
				const url = "/pages/top/top?times=" + times + "&" + "name=" + this.name;
				uni.navigateTo({
					url: url,
				})
			},
			runClick() {
				times += 1
				this.msg = times.toString() + "米"

			},
			runningDuration() {
				this.durationstr = duration.toString()
			},
			showButton() {
				times = -1
				this.runClick()
				this.startRun = true
			},
			hidenButton() {
				this.startRun = false
				this.topBtn = true
			},
			onSetInterval() {
				timer = setInterval(() => {
					const now = new Date().getTime() / 1000;
					console.log("setTimeout", gameid, duration, times, now.toString());

					// 请求游戏
					if (gameid == 0) {
						uni.request({
							url: "/api/getgame",
							method: "post",
							timeout: 500,
							success: res => {
								if (res.data.code == -1) {

								} else if (res.data.code != 0) {
									uni.showToast({
										"title": res.data.message + "(" + res.data.code + ")",
										duration: 2000
									})
								} else {
									console.info(res.data.data)
									gameid = res.data.data.GameId
									duration = res.data.data.Duration
									this.showButton()

								}
							},
							fail: res => {
								uni.showToast({
									"title": "请求接口失败",
									duration: 2000
								})
							},
						})
					}

					// 游戏中
					if (duration > 0) {
						this.runningDuration()
					}
					duration -= 1

					// 上传结果
					if (gameid != 0 && duration == 0) {
						this.hidenButton()
						uni.showToast({
							"title": "游戏结束",
							duration: 3000,
							position: "bottom",
						})
						uni.request({
							url: "/api/uploadresult",
							method: "post",
							header: {
								'content-type': 'application/json'
							},
							data: {
								times: times,
								user: this.name,
								gameid: gameid,
							},
							timeout: 500,
							success: res => {
								this.clearInterval()


							}
						})
					}



				}, 1000);

			},
			clearInterval() {
				// clearTime
				if (timer) {
					clearInterval(timer);
					timer = null;
					console.log("clearInterval");
				}
			},
		}
	}
</script>

<style>
	.container {
		margin-top: 30px;
		padding: 20px;
		font-size: 14px;
		line-height: 24px;
	}

	.imgcontainer {
		width: 100%;
		height: 100%;
		display: flex;
		justify-content: center;
		align-items: center;
	}

	.msg {
		height: 100%;
		flex: auto;
		margin-top: 50px;
		margin-bottom: 150px;
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
	}
</style>