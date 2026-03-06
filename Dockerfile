# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.1-base

# install custom nodes into comfyui (first node with --mode remote to fetch updated cache)
RUN comfy node install --exit-on-fail comfyui-image-saver@1.21.0 --mode remote
RUN comfy node install --exit-on-fail comfyui-impact-pack@8.28.2
RUN comfy node install --exit-on-fail rgthree-comfy@1.0.2512112053
# The following custom nodes were listed under unknown_registry and could not be automatically resolved (no aux_id / GitHub repo provided):
# - Power Lora Loader (rgthree)
# - Fast Groups Bypasser (rgthree)
# - easy showAnything
# - easy showAnything
# - MarkdownNote
# - Note
# - MarkdownNote
# - Input Parameters (Image Saver)

# download models into comfyui
RUN comfy model download --url https://huggingface.co/Comfy-Org/Qwen-Image-Edit_ComfyUI/resolve/main/split_files/diffusion_models/qwen_image_edit_2511_bf16.safetensors --relative-path models/diffusion_models --filename qwen_image_edit_2511_bf16.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/HunyuanVideo_1.5_repackaged/resolve/main/split_files/text_encoders/qwen_2.5_vl_7b_fp8_scaled.safetensors --relative-path models/text_encoders --filename qwen_2.5_vl_7b_fp8_scaled.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI/resolve/main/split_files/vae/qwen_image_vae.safetensors --relative-path models/vae --filename qwen_image_vae.safetensors

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/
