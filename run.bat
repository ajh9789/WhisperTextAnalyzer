@echo off
echo ============================================
echo 🎙️ WhisperTextAnalyzer Auto Start
echo ============================================

echo 🎙️ Starting Recorder
start python recorder/recorder.py

echo 🎙️ Starting STT Worker 1
start cmd /k "cd stt_worker && python -m celery -A stt_worker worker --loglevel=info --concurrency=1 --pool=solo -n stt_worker1"

echo 🎙️ Starting STT Worker 2
start cmd /k "cd stt_worker && python -m celery -A stt_worker worker --loglevel=info --concurrency=1 --pool=solo -n stt_worker2"

echo 🎙️ Starting Analyzer Worker
start cmd /k "cd analyzer_worker && python -m celery -A analyzer_worker worker --loglevel=info --concurrency=1 --pool=solo -n analyzer_worker"

echo 🎙️ Starting Listener
start python listener/listener.py

echo ✅ All components launched. Enjoy!
pause