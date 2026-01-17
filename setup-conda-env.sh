# Check if environment already exists
conda env list | grep wakeword_trainer

# If it exists, activate it. If not, create it.
if conda env list | grep -q wakeword_trainer; then
    echo "Environment 'wakeword_trainer' already exists. Activating..."
    conda activate wakeword_trainer
else
    echo "Creating new environment 'wakeword_trainer'..."
    conda create -n wakeword_trainer python=3.10 -y
    conda activate wakeword_trainer
    
    # Install all dependencies
    pip install jupyter ipykernel
    pip install 'numpy==1.26.4' 'scipy==1.13.1'
    pip install 'torch==2.4.0' 'torchaudio==2.4.0' torchvision
    pip install 'ai-edge-litert>=2.0.2,<3'
    pip install 'onnxruntime>=1.10.0,<2'
    pip install 'speexdsp-ns>=0.1.2,<1'
    
    git clone https://github.com/dscripka/openwakeword 2>/dev/null || echo "openwakeword already cloned"
    pip install -e ./openwakeword
    
    pip install mutagen torchinfo torchmetrics speechbrain audiomentations torch-audiomentations
    pip install acoustics onnxsim onnx onnx_graphsurgeon sng4onnx
    pip install pronouncing datasets deep-phonemizer
    pip install piper-phonemize-cross webrtcvad
    
    python -m ipykernel install --user --name=wakeword_trainer --display-name="WakeWord Trainer"
    echo "✅ Environment setup complete!"
fi

echo "============================================================"
echo "Remember to run conda activate wakeword_trainer now"
echo ""