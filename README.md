Minimal example for comparing the performance of ROCM with CPU

```sh
# Using Python 3.12 because I couldn't get misaki to install on 3.13+
sudo dnf install python3.12

# Setup and then run at least twice to account for the need to download files

bash setup_cpu.sh
source cpu.venv/bin/activate
time python run.py
time python run.py
deactivate

bash setup_rocm_nightly.sh
source rocm_nightly.venv/bin/activate
time python run.py
time python run.py
deactivate

bash setup_rocm_stable.sh
source rocm_stable.venv/bin/activate
time python run.py
time python run.py
deactivate

bash setup_cuda_stable.sh
source cuda_stable.venv/bin/activate
time python run.py
time python run.py
deactivate
```

My 2nd run.py times. The CUDA and CPU times are from the same laptop.

```
cuda_stable.venv
01:00.0 VGA compatible controller: NVIDIA Corporation TU116M [GeForce GTX 1660 Ti Mobile] (rev a1)
real    0m13.469s

cpu.venv
AMD Ryzen 7 4800H with Radeon Graphics
real    0m51.781s

rocm_nightly.venv with MIOPEN_FIND_MODE=fast
03:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Navi 48 [Radeon AI PRO R9700] (rev c0)
real    0m53.814s

rocm_stable.venv with MIOPEN_FIND_MODE=fast
03:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Navi 48 [Radeon AI PRO R9700] (rev c0)
real    0m53.889s

rocm_stable.venv
03:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Navi 48 [Radeon AI PRO R9700] (rev c0)
real    2m16.069s
```

I get these warnings in the ROCM environments without MIOPEN_FIND_MODE=fast:

```
MIOpen(HIP): Warning [IsEnoughWorkspace] [GetSolutionsFallback WTI] Solver <GemmFwdRest>, workspace required: 156304896, provided ptr: 0 size: 0
MIOpen(HIP): Warning [IsEnoughWorkspace] [EvaluateInvokers] Solver <GemmFwdRest>, workspace required: 156304896, provided ptr: 0 size: 0
```

MIOpen and hipBLASLt logging

```sh
MIOPEN_ENABLE_LOGGING=1 MIOPEN_ENABLE_LOGGING_CMD=1 HIPBLASLT_LOG_MASK=32 HIPBLASLT_LOG_FILE="kokoro_tts_hipblaslt_log.txt" TORCH_BLAS_PREFER_HIPBLASLT=1 python run.py
sort kokoro_tts_hipblaslt_log.txt | uniq -c | sort -nr > kokoro_tts_sorted_hipblaslt_log.txt
```
