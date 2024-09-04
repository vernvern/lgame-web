<template>
	<view>
		<view class="imgcontainer">
			<image mode="scaleToFill" src="../../static/1.jpg"></image>
		</view>

		<uni-section title="用户名" subTitle="最后排名显示的名字" type="line" padding>
			<uni-easyinput v-model="name" focus @input="input"></uni-easyinput>
		</uni-section>

		<button v-on:click="random()" class="startbtm"> 随机用户名 </button>
		<button v-on:click="toStart()" class="startbtm"> 开始游戏 </button>
	</view>


</template>

<script>
	// import lunbo from '@/components/lunbo.vue';

	export default {
		// components: {
		// 	lunbo,
		// },
		mounted() {
			this.random()
		},
		data() {
			return {
				name: ""
			}
		},
		methods: {
			toStart() {
				if (this.name == "") {
					uni.showToast({
						icon: "error",
						"title": "需要名字",
						duration: 2000
					})
					return
				}

				const url = "/pages/game/game?name=" + this.name;
				uni.navigateTo({
					url: url,
				})
			},
			random() {
				var str = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I',
					'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
				];

				var res = "";
				for (var i = 0; i < 6; i++) {
					var id = Math.ceil(Math.random() * 35);
					res += str[id];
				}
				this.name = res;
			}
		}
	}
</script>

<style>
	.imgcontainer {
		width: 100%;
		height: 100%;
		display: flex;
		justify-content: center;
		align-items: center;
	}

	.adminbtm {
		width: 100px;
		margin-bottom: 100px;
	}

	.startbtm {
		margin-top: 10px;
		width: 150px;

	}
</style>