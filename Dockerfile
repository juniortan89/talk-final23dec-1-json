# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.0-base

# Install custom nodes for InfiniteTalk/WanVideo
RUN cd /comfyui/custom_nodes && \
    git clone https://github.com/kijai/ComfyUI-WanVideoWrapper.git && \
    git clone https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git

# Install dependencies for custom nodes
RUN cd /comfyui/custom_nodes/ComfyUI-WanVideoWrapper && pip install -r requirements.txt || true
RUN cd /comfyui/custom_nodes/ComfyUI-VideoHelperSuite && pip install -r requirements.txt || true

# download models into comfyui
RUN comfy model download --url https://huggingface.co/Kijai/WanVideo_comfy_fp8_scaled/resolve/main/InfiniteTalk/Wan2_1-InfiniteTalk-Single_fp8_e4m3fn_scaled_KJ.safetensors --relative-path models/diffusion_models --filename Wan2_1-InfiniteTalk-Single_fp8_e4m3fn_scaled_KJ.safetensors
RUN comfy model download --url https://huggingface.co/Kijai/WanVideo_comfy_fp8_scaled/resolve/main/I2V/Wan2_1-I2V-14B-480p_fp8_e5m2_scaled_KJ.safetensors --relative-path models/diffusion_models --filename Wan2_1-I2V-14B-480p_fp8_e5m2_scaled_KJ.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/vae/wan_2.1_vae.safetensors --relative-path models/vae --filename wan_2.1_vae.safetensors
RUN comfy model download --url https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Lightx2v/lightx2v_I2V_14B_480p_cfg_step_distill_rank64_bf16.safetensors --relative-path models/loras --filename lightx2v_I2V_14B_480p_cfg_step_distill_rank64_bf16.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/clip_vision/clip_vision_h.safetensors --relative-path models/clip_vision --filename clip_vision_h.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/text_encoders/umt5_xxl_fp16.safetensors --relative-path models/text_encoders --filename umt5_xxl_fp16.safetensors
RUN comfy model download --url https://huggingface.co/Kijai/wav2vec2_safetensors/resolve/main/wav2vec2-chinese-base_fp16.safetensors --relative-path models/transformers/TencentGameMate --filename wav2vec2-chinese-base_fp16.safetensors
RUN comfy model download --url https://huggingface.co/Kijai/MelBandRoFormer_comfy/resolve/main/MelBandRoformer_fp32.safetensors --relative-path models/diffusion_models --filename MelBandRoformer_fp32.safetensors
