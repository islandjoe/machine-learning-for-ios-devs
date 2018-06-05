import turicreate as tc

data = tc.SFrame("cats-dogs.sframe")

# 80/20 split
train_data, test_data = data.random_split(0.8)
# Train our classifier
model = tc.image_classifier.create(train_data, target="label")
# 
predicts = model.predict(test_data)
#
metrics = model.evaluate(test_data)
print(metrics["accuracy"])
# Save as model
model.save("CatDogClassifier.model")
# Export to CoreML format
model.export_coreml("CatDogClassifier.mlmodel")
