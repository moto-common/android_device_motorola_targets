import os

# Define the base directory and overlay information
base_directory = "./sofia"
overlays = [
    {
        "sku": "XT2045-1",
        "dir": "rav",
        "package": "com.android.settings.rav.regulatory1"
    },
    {
        "sku": "XT2045-2",
        "dir": "rav",
        "package": "com.android.settings.rav.regulatory2"
    },
    {
        "sku": "XT2045-3",
        "dir": "rav",
        "package": "com.android.settings.rav.regulatory3"
    },
    {
        "sku": "XT2045-6",
        "dir": "rav",
        "package": "com.android.settings.rav.regulatory6"
    },
    {
        "sku": "XT2041-1",
        "dir": "sofiar",
        "package": "com.android.settings.sofiar.regulatory1"
    },
    {
        "sku": "XT2041-3",
        "dir": "sofiar",
        "package": "com.android.settings.sofiar.regulatory3"
    },
    {
        "sku": "XT2041-4",
        "dir": "sofia",
        "package": "com.android.settings.sofia.regulatory4"
    },
    {
        "sku": "XT2041-5",
        "dir": "sofia",
        "package": "com.android.settings.sofia.regulatory5"
    },
    {
        "sku": "XT2041-6",
        "dir": "sofia",
        "package": "com.android.settings.sofia.regulatory6"
    },
    {
        "sku": "XT2041-7",
        "dir": "sofia",
        "package": "com.android.settings.sofia.regulatory7"
    },
    {
        "sku": "XT2043-7",
        "dir": "sofiap",
        "package": "com.android.settings.sofiap.regulatory7"
    },
    {
        "sku": "XT2043-8",
        "dir": "sofiap",
        "package": "com.android.settings.sofiap.regulatory8"
    },
    # Add more overlays as needed
]

# Create the overlay directories and files
for overlay in overlays:
    overlay_directory = os.path.join("./"+overlay["dir"], overlay["sku"])
    os.makedirs(overlay_directory, exist_ok=True)

    # Create AndroidManifest.xml
    manifest_content = f'''<manifest xmlns:android="http://schemas.android.com/apk/res/android" 
        package="{overlay["package"]}">
    <overlay
        android:isStatic="true"
        android:priority="800"
        android:requiredSystemPropertyName="ro.boot.hardware.sku"
        android:requiredSystemPropertyValue="{overlay["sku"]}"
        android:targetPackage="com.android.settings" />
</manifest>'''
    manifest_path = os.path.join(overlay_directory, "AndroidManifest.xml")
    with open(manifest_path, "w") as manifest_file:
        manifest_file.write(manifest_content)

    # Create Android.bp
    bp_content = f'''runtime_resource_overlay {{
    name: "{overlay["sku"]}RegulatoryOverlay",
    vendor: true,
}}'''
    bp_path = os.path.join(overlay_directory, "Android.bp")
    with open(bp_path, "w") as bp_file:
        bp_file.write(bp_content)

    # Create regulatory_info.png in the drawable directory
    drawable_directory = os.path.join(overlay_directory, "res", "drawable")
    os.makedirs(drawable_directory, exist_ok=True)
    print(f"Created overlay: {overlay['sku']}")

