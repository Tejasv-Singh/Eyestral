#!/bin/bash

deepspeed cumo/train/train_mem.py \
    --deepspeed ./mistral_7b_eyestral/zero3_offload.json \
    --model_name_or_path shi-labs/CuMo-mistral-7b \
    --version mistral_instruct_system \
    --data_path $CuMo_DIR/data-sft/blind_dataset/train/train_formatted.json \
    --image_folder $CuMo_DIR/data-sft/blind_dataset/train \
    --vision_tower openai/clip-vit-large-patch14-336 \
    --vision_tower_dir $CuMo_DIR/clip-model/clip-vit-large-patch14-336/pytorch_model.bin \
    --scales 1,3 \
    --mm_projector_type smoe_mlp \
    --mlp_smoe True \
    --clip_smoe True \
    --num_experts 4 \
    --num_selected 2 \
    --balance_loss_coef 0.1 \
    --router_z_loss_coef 0.01 \
    --mm_vision_select_layer -2 \
    --mm_use_im_start_end False \
    --mm_use_im_patch_token False \
    --image_aspect_ratio pad \
    --group_by_modality_length True \
    --bf16 True \
    --output_dir $CuMo_DIR/checkpoints/eyestral-7b-sft \
    --num_train_epochs 1 \
    --per_device_train_batch_size 4 \
    --per_device_eval_batch_size 4 \
    --gradient_accumulation_steps 2 \
    --evaluation_strategy "no" \
    --save_strategy "steps" \
    --save_steps 50000 \
    --save_total_limit 1 \
    --learning_rate 4e-6 \
    --weight_decay 0. \
    --warmup_ratio 0.03 \
    --lr_scheduler_type "cosine" \
    --logging_steps 1 \
    --tf32 True \
    --model_max_length 4096 \
    --gradient_checkpointing True \
    --dataloader_num_workers 4 \
    --lazy_preprocess True \
    --report_to none