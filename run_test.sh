#!/bin/bash

### Required parameters (modify before calling the script!) ###

# Download the WikiSplit data from:
# https://github.com/google-research-datasets/wiki-split
WIKISPLIT_DIR=/home/share/zh/corpus/pku_paraphrase_lasertagger
# Preprocessed data and models will be stored here.
OUTPUT_DIR=./logs_test
# Download the pretrained BERT model:
# https://storage.googleapis.com/bert_models/2018_10_18/cased_L-12_H-768_A-12.zip
BERT_BASE_DIR=/home/share/zh/models/chinese_roberta_wwm_ext_L-12_H-768_A-12

### Optional parameters ###

# If you train multiple models on the same data, change this label.
EXPERIMENT=pku_paraphrase
# To quickly test that model training works, set the number of epochs to a
# smaller value (e.g. 0.01).
NUM_EPOCHS=3.0
BATCH_SIZE=32
PHRASE_VOCAB_SIZE=500
MAX_INPUT_EXAMPLES=1000000
SAVE_CHECKPOINT_STEPS=500

###########################


### 4. Prediction

# Get the most recently exported model directory.
TIMESTAMP=$(ls "${OUTPUT_DIR}/models/${EXPERIMENT}/export/" | \
            grep -v "temp-" | sort -r | head -1)
SAVED_MODEL_DIR=${OUTPUT_DIR}/models/${EXPERIMENT}/export/${TIMESTAMP}
PREDICTION_FILE=${OUTPUT_DIR}/models/${EXPERIMENT}/pred.tsv

python predict_main.py \
  --input_file=${WIKISPLIT_DIR}/validation.tsv \
  --input_format=wikisplit \
  --output_file=${PREDICTION_FILE} \
  --label_map_file=${OUTPUT_DIR}/label_map.txt \
  --vocab_file=${BERT_BASE_DIR}/vocab.txt \
  --saved_model=${SAVED_MODEL_DIR}


### 5. Evaluation

python score_main.py --prediction_file=${PREDICTION_FILE}
