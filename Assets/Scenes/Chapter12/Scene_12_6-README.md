# Scene_12_6：累积帧运动模糊

打开本目录的 `Scene_12_6.unity` 并点击 Play，在 Game 视图观察。注意工程中 `Assets/Scenes/Chapter11/Chapter12` 也有同名场景，本次配置的是 `Assets/Scenes/Chapter12/Scene_12_6.unity`。

场景采用内置渲染管线，Main Camera 已挂载 `Translating` 和 `MotionBlur`，后者引用 `Assets/Shaders/Chapter12/Chapter12-MotionBlur.shader`。这三个文件沿用原有实现，本次调整场景与材质。

| 参数 | 默认值 | 用途 |
| --- | --- | --- |
| Translating / Start Point | (-9, 5, -13) | 起点 |
| Translating / End Point | (9, 5, -13) | 终点 |
| Translating / Look At | (0, 1.5, 2) | 固定观察点 |
| Translating / Speed | 2.5 | 原脚本 Slerp 插值系数，不是米/秒 |
| Translating / Pingpong | 开启 | 到达端点后返回 |
| MotionBlur / Blur Amount | 0.85 | 历史帧保留比例，越高拖影越明显 |

原运动脚本逐帧逼近端点，因此会先快后慢，在接近端点时模糊自然减弱，随后反向运动。观察几秒即可看到循环。

场景中的白色立柱、地面刻线及两侧标记用于观察高对比边缘的拖影和前后景视差。青色方块、黄色球和橙色胶囊用于观察不同轮廓。材质保存在 `Assets/Materials/Chapter12/MotionBlurDemo`。

运行时将 Blur Amount 调为 0 可观察清晰画面，再调回 0.85 对照。此算法混合当前画面与历史累积纹理，不使用速度缓冲或深度重建，具有残影特征，效果随帧率和相机运动速度变化。

2026-10-12 验证：Play 模式确认相机位置变化；控制台未发现错误或警告；场景检查无缺失脚本或损坏 Prefab。另以固定分辨率连续渲染 24 个移动视角，在同一最终视角对比 0.85 与 0，RGB 平均差约 11.73/255，并人工确认边缘拖影。此对照是受控渲染，不是实时帧率下的录像。

- [开启模糊的渲染对照](../../../Captures/MotionBlur-Verified-On.png)
- [关闭模糊的渲染对照](../../../Captures/MotionBlur-Verified-Off.png)
