from utils_rouge import rouge_eval, rouge_log


rouge_ref_dir = './output/reference'
rouge_dec_dir = './output/decoded'
print("Decoder has finished reading dataset for single_pass.")
print("Now starting ROUGE eval...")
results_dict = rouge_eval(rouge_ref_dir, rouge_dec_dir)
rouge_log(results_dict, './output')
