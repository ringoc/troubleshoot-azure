# Enable Red Hat Golden Image with BYOS in Azure

# What is this document?

This document provides step by step instruction to enable Red Hat Golden Image with Bring-your-own-subscription (BYOS) in Azure by registering a Red Hat developer account.

# Create a Red Hat Account

If you don&#39;t have a Red Hat account yet, go to Red Hat portal and [register an account](https://sso.redhat.com/auth/realms/redhat-external/login-actions/registration?client_id=https%3A%2F%2Fwww.redhat.com%2Fwapps%2Fugc-oidc&amp;tab_id=ncmf5w6PJf8). You can use either MSFT corporate or personal. (It is recommended to use MSFT corporate account so that any other RHEL for Service Provider On Demand can be grouped into single place/account)

![image](https://user-images.githubusercontent.com/202669/148623727-c6690887-c338-48d9-b87e-86351511b6e7.png)

Follow the instruction to confirm your email address. Once the account is active, [Customer Portal](https://access.redhat.com/management) should be available to access. There should be no subscription exists. Next is to enable the Developer subscription.

![image](https://user-images.githubusercontent.com/202669/148623746-47c68919-f712-47c5-a519-8a233ba02d86.png)

# Red Hat Developer Subscription

Prior to activate the Red Hat Golden Image, you must have an active Red Hat Developer Subscription for Individuals which gives you entitlement usage. To enable the Developer Subscription, go to [Red Hat Developer website](https://developers.redhat.com/).

![image](https://user-images.githubusercontent.com/202669/148623765-5fcda8f5-94e9-493a-8ff2-dd12da45382e.png)

Click on the Login on the page, login with the same account above. Then follow the instruction to verify the account in your email inbox.

![image](https://user-images.githubusercontent.com/202669/148623771-340c8830-1d72-4698-9def-5163030b2095.png)

Once the developer subscription account has been enabled. Go back to Customer Portal. Under Subscription, you should see 2 additional subscriptions are now appeared Red Hat developer Subscription for Individual and Red Hat Beta Access.

![image](https://user-images.githubusercontent.com/202669/148623779-88282c40-d85f-4e37-a438-f1cf69a24a72.png)

Click on the Red Hat Developer Subscription for Individuals. It shows the number of entitlement and content available under the Developer subscription.

![image](https://user-images.githubusercontent.com/202669/148623784-50397ecd-cc4a-441c-8e8f-97a929dc0498.png)

The developer subscription should offer 15 licenses and a whole bunch of content. Once the subscription is active, we can then start enable Cloud Access.

# Cloud Access

To enable the Cloud Access, go to Cloud Access tab. Click on &quot;Enable a new provider&quot;.

![image](https://user-images.githubusercontent.com/202669/148623787-04c3159a-b8dc-43c3-b1e5-f5ea6fe737f7.png)

Choose Microsoft Azure from the drop down, and click on &quot;Add subscription manually&quot;

![image](https://user-images.githubusercontent.com/202669/148623839-9556949e-ac44-4341-9fda-62523a7f62ad.png)

Fill in your Microsoft Azure Subscription ID and Name, and &quot;Max Enabled Entitlement Quantity&quot;

![image](https://user-images.githubusercontent.com/202669/148623874-ba6692c9-e8bb-406b-9268-11795a349613.png)

Wait for a few hours (up to 3 hours) and check again in Azure Marketplace Portal.

# RHEL bring-your-own-subscription Gold Images in Azure

Once you can see the Red Hat Golden Image is available in the Private Offering under Marketplace. You have successfully enabled the Red Hat Golden Image.

![image](https://user-images.githubusercontent.com/202669/148623894-15ad12cb-4895-4c49-b743-a443c1fbfedd.png)

Next follow the [Azure documentation](https://docs.microsoft.com/en-us/azure/virtual-machines/workloads/redhat/byos#use-the-red-hat-gold-images-from-the-azure-portal) to deploy the RHEL golden image through Portal, Azure CLI or PowerShell. Then use Subscription-Manager to register the VM with Red Hat.

Happy RHEL BYOS !

# Metadata

Author: Ringo Chan (@ringochan)

Date: 22nd September 2021

Version 1.0
