from kokoro import KPipeline
import soundfile
import torch

pipeline = KPipeline(lang_code='a')

# with open('sample.txt') as f:
#     text = f.read()

text = '''
[Kokoro](/kˈOkəɹO/) is an open-weight TTS model with 82 million parameters. Despite its lightweight architecture, it delivers comparable quality to larger models while being significantly faster and more cost-efficient. With Apache-licensed weights, [Kokoro](/kˈOkəɹO/) can be deployed anywhere from production environments to personal projects.
'''

generator = pipeline(text, voice='af_bella')

for i, (gs, ps, audio) in enumerate(generator):
    print(i, gs, ps, len(audio))
    # soundfile.write(f'{i}.wav', audio, 24000)
