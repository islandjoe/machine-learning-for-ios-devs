import turicreate as tc

# Load images for analysis
data = tc.image_analysis.load_images("training-data", with_path=True)
# Sift the images according to their file name
data["label"] = data["path"].apply(lambda path: "dog" if "dog" in path else "cat")
# Save to SFrame format
data.save("cats-dogs.sframe")
# Visualize
data.explore()
