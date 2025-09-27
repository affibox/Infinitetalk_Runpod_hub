#!/bin/bash
set -e

# Update system and install wget
apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/*

# Extra Python dependencies
pip install -U "huggingface_hub[hf_transfer]"
pip install runpod websocket-client librosa

# Go to ComfyUI custom_nodes folder
cd /workspace/ComfyUI/custom_nodes

# Install additional custom nodes
git clone https://github.com/city96/ComfyUI-GGUF && cd ComfyUI-GGUF && pip install -r requirements.txt && cd ..
git clone https://github.com/kijai/ComfyUI-KJNodes && cd ComfyUI-KJNodes && pip install -r requirements.txt && cd ..
git clone https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite && cd ComfyUI-VideoHelperSuite && pip install -r requirements.txt && cd ..
git clone https://github.com/orssorbit/ComfyUI-wanBlockswap
git clone https://github.com/kijai/ComfyUI-MelBandRoFormer && cd ComfyUI-MelBandRoFormer && pip install -r requirements.txt && cd ..
git clone https://github.com/kijai/ComfyUI-WanVideoWrapper && cd ComfyUI-WanVideoWrapper && pip install -r requirements.txt && cd ..

# Download required models
mkdir -p /workspace/ComfyUI/models/{diffusion_models,loras,vae,text_encoders,clip_vision}

wget https://huggingface.co/Kijai/WanVideo_comfy_GGUF/resolve/main/InfiniteTalk/Wan2_1-InfiniteTalk_Single_Q8.gguf \
     -O /workspace/ComfyUI/models/diffusion_models/Wan2_1-InfiniteTalk_Single_Q8.gguf

wget https://huggingface.co/Kijai/WanVideo_comfy_GGUF/resolve/main/InfiniteTalk/Wan2_1-InfiniteTalk_Multi_Q8.gguf \
     -O /workspace/ComfyUI/models/diffusion_models/Wan2_1-InfiniteTalk_Multi_Q8.gguf

wget https://huggingface.co/city96/Wan2.1-I2V-14B-480P-gguf/resolve/main/wan2.1-i2v-14b-480p-Q8_0.gguf \
     -O /workspace/ComfyUI/models/diffusion_models/wan2.1-i2v-14b-480p-Q8_0.gguf

wget https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Lightx2v/lightx2v_I2V_14B_480p_cfg_step_distill_rank64_bf16.safetensors \
     -O /workspace/ComfyUI/models/loras/lightx2v_I2V_14B_480p_cfg_step_distill_rank64_bf16.safetensors

wget https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Wan2_1_VAE_bf16.safetensors \
     -O /workspace/ComfyUI/models/vae/Wan2_1_VAE_bf16.safetensors

wget https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/umt5-xxl-enc-bf16.safetensors \
     -O /workspace/ComfyUI/models/text_encoders/umt5-xxl-enc-bf16.safetensors

wget https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/clip_vision/clip_vision_h.safetensors \
     -O /workspace/ComfyUI/models/clip_vision/clip_vision_h.safetensors

wget https://huggingface.co/Kijai/MelBandRoFormer_comfy/resolve/main/MelBandRoformer_fp16.safetensors \
     -O /workspace/ComfyUI/models/diffusion_models/MelBandRoformer_fp16.safetensors

echo "✅ Provisioning complete. You can now run ComfyUI on port 8188."
