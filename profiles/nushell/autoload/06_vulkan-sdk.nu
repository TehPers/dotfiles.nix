let VULKAN_SDK = "~/VulkanSDK/SDKs/latest" | path expand | path join $nu.os-info.arch
if ($VULKAN_SDK | path exists) {
    $env.VULKAN_SDK = $VULKAN_SDK
}
