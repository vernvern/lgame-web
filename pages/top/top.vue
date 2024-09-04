<template>
	<view>
		<lunbo></lunbo>
		<view>
			<text v-if="name != ''">我的名字：{{name}}  </text>
		</view>
		<view>
			<text v-if="times > 0">我的分数：{{times}} </text>
		</view>
		
		<uni-section title="Top" type="line">
			<uni-list>
				<uni-list-item  v-for="item in items" 
				:title="item.user" 
				:showBadge="false" 
				inverted=true
				:rightText="item.times.toString()" 
				:badge-text="item.times.toString()" 
				 />
			</uni-list>
		</uni-section>
	</view>
</template>

<script>
	import lunbo from '@/components/lunbo.vue';
	let timer = null;
	export default {
		components: {
			lunbo,
		},
		
		data() {
			return {
				items: [
					
				],
				badgeStyle: {
					"max-num": 999,
				},

			}
		},
		beforeUnmount() {
			this.clearInterval();
		},
		onBackPress() {
			this.clearInterval();
		},
		mounted() {
			this.onSetInterval()
		},
		onLoad(option) {
			this.name = option.name
			this.times = option.times
		},
		methods: {

			onSetInterval() {
				timer = setInterval(() => {
						uni.request({
							url: "/api/top",
							method: "post",
							header: {
								'content-type': 'application/json'
							},
							timeout: 500,
							success: res => {
								this.items = []
								this.items = res.data.data.top

								
							}
						})



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
	
	
	

</style>