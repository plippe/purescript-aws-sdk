

-- | <fullname>AWS Security Token Service</fullname> <p>The AWS Security Token Service (STS) is a web service that enables you to request temporary, limited-privilege credentials for AWS Identity and Access Management (IAM) users or for users that you authenticate (federated users). This guide provides descriptions of the STS API. For more detailed information about using this service, go to <a href="http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp.html">Temporary Security Credentials</a>. </p> <note> <p> As an alternative to using the API, you can use one of the AWS SDKs, which consist of libraries and sample code for various programming languages and platforms (Java, Ruby, .NET, iOS, Android, etc.). The SDKs provide a convenient way to create programmatic access to STS. For example, the SDKs take care of cryptographically signing requests, managing errors, and retrying requests automatically. For information about the AWS SDKs, including how to download and install them, see the <a href="http://aws.amazon.com/tools/">Tools for Amazon Web Services page</a>. </p> </note> <p>For information about setting up signatures and authorization through the API, go to <a href="http://docs.aws.amazon.com/general/latest/gr/signing_aws_api_requests.html">Signing AWS API Requests</a> in the <i>AWS General Reference</i>. For general information about the Query API, go to <a href="http://docs.aws.amazon.com/IAM/latest/UserGuide/IAM_UsingQueryAPI.html">Making Query Requests</a> in <i>Using IAM</i>. For information about using security tokens with other AWS products, go to <a href="http://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-services-that-work-with-iam.html">AWS Services That Work with IAM</a> in the <i>IAM User Guide</i>. </p> <p>If you're new to AWS and need additional technical information about a specific AWS product, you can find the product's technical documentation at <a href="http://aws.amazon.com/documentation/">http://aws.amazon.com/documentation/</a>. </p> <p> <b>Endpoints</b> </p> <p>The AWS Security Token Service (STS) has a default endpoint of https://sts.amazonaws.com that maps to the US East (N. Virginia) region. Additional regions are available and are activated by default. For more information, see <a href="http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_enable-regions.html">Activating and Deactivating AWS STS in an AWS Region</a> in the <i>IAM User Guide</i>.</p> <p>For information about STS endpoints, see <a href="http://docs.aws.amazon.com/general/latest/gr/rande.html#sts_region">Regions and Endpoints</a> in the <i>AWS General Reference</i>.</p> <p> <b>Recording API requests</b> </p> <p>STS supports AWS CloudTrail, which is a service that records AWS calls for your AWS account and delivers log files to an Amazon S3 bucket. By using information collected by CloudTrail, you can determine what requests were successfully made to STS, who made the request, when it was made, and so on. To learn more about CloudTrail, including how to turn it on and find your log files, see the <a href="http://docs.aws.amazon.com/awscloudtrail/latest/userguide/what_is_cloud_trail_top_level.html">AWS CloudTrail User Guide</a>.</p>
module AWS.STS where

import Control.Monad.Aff (Aff)
import Data.Foreign.NullOrUndefined (NullOrUndefined)
import Data.Map (Map)
import Data.Newtype (class Newtype)
import Data.Unit (Unit, unit)

import AWS.Request as AWS

serviceName = "STS" :: String


-- | <p>Returns a set of temporary security credentials (consisting of an access key ID, a secret access key, and a security token) that you can use to access AWS resources that you might not normally have access to. Typically, you use <code>AssumeRole</code> for cross-account access or federation. For a comparison of <code>AssumeRole</code> with the other APIs that produce temporary credentials, see <a href="http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html">Requesting Temporary Security Credentials</a> and <a href="http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html#stsapi_comparison">Comparing the AWS STS APIs</a> in the <i>IAM User Guide</i>.</p> <p> <b>Important:</b> You cannot call <code>AssumeRole</code> by using AWS root account credentials; access is denied. You must use credentials for an IAM user or an IAM role to call <code>AssumeRole</code>. </p> <p>For cross-account access, imagine that you own multiple accounts and need to access resources in each account. You could create long-term credentials in each account to access those resources. However, managing all those credentials and remembering which one can access which account can be time consuming. Instead, you can create one set of long-term credentials in one account and then use temporary security credentials to access all the other accounts by assuming roles in those accounts. For more information about roles, see <a href="http://docs.aws.amazon.com/IAM/latest/UserGuide/roles-toplevel.html">IAM Roles (Delegation and Federation)</a> in the <i>IAM User Guide</i>. </p> <p>For federation, you can, for example, grant single sign-on access to the AWS Management Console. If you already have an identity and authentication system in your corporate network, you don't have to recreate user identities in AWS in order to grant those user identities access to AWS. Instead, after a user has been authenticated, you call <code>AssumeRole</code> (and specify the role with the appropriate permissions) to get temporary security credentials for that user. With those temporary security credentials, you construct a sign-in URL that users can use to access the console. For more information, see <a href="http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp.html#sts-introduction">Common Scenarios for Temporary Credentials</a> in the <i>IAM User Guide</i>.</p> <p>The temporary security credentials are valid for the duration that you specified when calling <code>AssumeRole</code>, which can be from 900 seconds (15 minutes) to a maximum of 3600 seconds (1 hour). The default is 1 hour. </p> <p>The temporary security credentials created by <code>AssumeRole</code> can be used to make API calls to any AWS service with the following exception: you cannot call the STS service's <code>GetFederationToken</code> or <code>GetSessionToken</code> APIs.</p> <p>Optionally, you can pass an IAM access policy to this operation. If you choose not to pass a policy, the temporary security credentials that are returned by the operation have the permissions that are defined in the access policy of the role that is being assumed. If you pass a policy to this operation, the temporary security credentials that are returned by the operation have the permissions that are allowed by both the access policy of the role that is being assumed, <i> <b>and</b> </i> the policy that you pass. This gives you a way to further restrict the permissions for the resulting temporary security credentials. You cannot use the passed policy to grant permissions that are in excess of those allowed by the access policy of the role that is being assumed. For more information, see <a href="http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_control-access_assumerole.html">Permissions for AssumeRole, AssumeRoleWithSAML, and AssumeRoleWithWebIdentity</a> in the <i>IAM User Guide</i>.</p> <p>To assume a role, your AWS account must be trusted by the role. The trust relationship is defined in the role's trust policy when the role is created. That trust policy states which accounts are allowed to delegate access to this account's role. </p> <p>The user who wants to access the role must also have permissions delegated from the role's administrator. If the user is in a different account than the role, then the user's administrator must attach a policy that allows the user to call AssumeRole on the ARN of the role in the other account. If the user is in the same account as the role, then you can either attach a policy to the user (identical to the previous different account user), or you can add the user as a principal directly in the role's trust policy. In this case, the trust policy acts as the only resource-based policy in IAM, and users in the same account as the role do not need explicit permission to assume the role. For more information about trust policies and resource-based policies, see <a href="http://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html">IAM Policies</a> in the <i>IAM User Guide</i>.</p> <p> <b>Using MFA with AssumeRole</b> </p> <p>You can optionally include multi-factor authentication (MFA) information when you call <code>AssumeRole</code>. This is useful for cross-account scenarios in which you want to make sure that the user who is assuming the role has been authenticated using an AWS MFA device. In that scenario, the trust policy of the role being assumed includes a condition that tests for MFA authentication; if the caller does not include valid MFA information, the request to assume the role is denied. The condition in a trust policy that tests for MFA authentication might look like the following example.</p> <p> <code>"Condition": {"Bool": {"aws:MultiFactorAuthPresent": true}}</code> </p> <p>For more information, see <a href="http://docs.aws.amazon.com/IAM/latest/UserGuide/MFAProtectedAPI.html">Configuring MFA-Protected API Access</a> in the <i>IAM User Guide</i> guide.</p> <p>To use MFA with <code>AssumeRole</code>, you pass values for the <code>SerialNumber</code> and <code>TokenCode</code> parameters. The <code>SerialNumber</code> value identifies the user's hardware or virtual MFA device. The <code>TokenCode</code> is the time-based one-time password (TOTP) that the MFA devices produces. </p>
assumeRole :: forall eff. AssumeRoleRequest -> Aff (err :: AWS.RequestError | eff) AssumeRoleResponse
assumeRole = AWS.request serviceName "assumeRole" 


-- | <p>Returns a set of temporary security credentials for users who have been authenticated via a SAML authentication response. This operation provides a mechanism for tying an enterprise identity store or directory to role-based AWS access without user-specific credentials or configuration. For a comparison of <code>AssumeRoleWithSAML</code> with the other APIs that produce temporary credentials, see <a href="http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html">Requesting Temporary Security Credentials</a> and <a href="http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html#stsapi_comparison">Comparing the AWS STS APIs</a> in the <i>IAM User Guide</i>.</p> <p>The temporary security credentials returned by this operation consist of an access key ID, a secret access key, and a security token. Applications can use these temporary security credentials to sign calls to AWS services.</p> <p>The temporary security credentials are valid for the duration that you specified when calling <code>AssumeRole</code>, or until the time specified in the SAML authentication response's <code>SessionNotOnOrAfter</code> value, whichever is shorter. The duration can be from 900 seconds (15 minutes) to a maximum of 3600 seconds (1 hour). The default is 1 hour.</p> <p>The temporary security credentials created by <code>AssumeRoleWithSAML</code> can be used to make API calls to any AWS service with the following exception: you cannot call the STS service's <code>GetFederationToken</code> or <code>GetSessionToken</code> APIs.</p> <p>Optionally, you can pass an IAM access policy to this operation. If you choose not to pass a policy, the temporary security credentials that are returned by the operation have the permissions that are defined in the access policy of the role that is being assumed. If you pass a policy to this operation, the temporary security credentials that are returned by the operation have the permissions that are allowed by the intersection of both the access policy of the role that is being assumed, <i> <b>and</b> </i> the policy that you pass. This means that both policies must grant the permission for the action to be allowed. This gives you a way to further restrict the permissions for the resulting temporary security credentials. You cannot use the passed policy to grant permissions that are in excess of those allowed by the access policy of the role that is being assumed. For more information, see <a href="http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_control-access_assumerole.html">Permissions for AssumeRole, AssumeRoleWithSAML, and AssumeRoleWithWebIdentity</a> in the <i>IAM User Guide</i>.</p> <p>Before your application can call <code>AssumeRoleWithSAML</code>, you must configure your SAML identity provider (IdP) to issue the claims required by AWS. Additionally, you must use AWS Identity and Access Management (IAM) to create a SAML provider entity in your AWS account that represents your identity provider, and create an IAM role that specifies this SAML provider in its trust policy. </p> <p>Calling <code>AssumeRoleWithSAML</code> does not require the use of AWS security credentials. The identity of the caller is validated by using keys in the metadata document that is uploaded for the SAML provider entity for your identity provider. </p> <important> <p>Calling <code>AssumeRoleWithSAML</code> can result in an entry in your AWS CloudTrail logs. The entry includes the value in the <code>NameID</code> element of the SAML assertion. We recommend that you use a NameIDType that is not associated with any personally identifiable information (PII). For example, you could instead use the Persistent Identifier (<code>urn:oasis:names:tc:SAML:2.0:nameid-format:persistent</code>).</p> </important> <p>For more information, see the following resources:</p> <ul> <li> <p> <a href="http://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_saml.html">About SAML 2.0-based Federation</a> in the <i>IAM User Guide</i>. </p> </li> <li> <p> <a href="http://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_saml.html">Creating SAML Identity Providers</a> in the <i>IAM User Guide</i>. </p> </li> <li> <p> <a href="http://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_saml_relying-party.html">Configuring a Relying Party and Claims</a> in the <i>IAM User Guide</i>. </p> </li> <li> <p> <a href="http://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-idp_saml.html">Creating a Role for SAML 2.0 Federation</a> in the <i>IAM User Guide</i>. </p> </li> </ul>
assumeRoleWithSAML :: forall eff. AssumeRoleWithSAMLRequest -> Aff (err :: AWS.RequestError | eff) AssumeRoleWithSAMLResponse
assumeRoleWithSAML = AWS.request serviceName "assumeRoleWithSAML" 


-- | <p>Returns a set of temporary security credentials for users who have been authenticated in a mobile or web application with a web identity provider, such as Amazon Cognito, Login with Amazon, Facebook, Google, or any OpenID Connect-compatible identity provider.</p> <note> <p>For mobile applications, we recommend that you use Amazon Cognito. You can use Amazon Cognito with the <a href="http://aws.amazon.com/sdkforios/">AWS SDK for iOS</a> and the <a href="http://aws.amazon.com/sdkforandroid/">AWS SDK for Android</a> to uniquely identify a user and supply the user with a consistent identity throughout the lifetime of an application.</p> <p>To learn more about Amazon Cognito, see <a href="http://docs.aws.amazon.com/mobile/sdkforandroid/developerguide/cognito-auth.html#d0e840">Amazon Cognito Overview</a> in the <i>AWS SDK for Android Developer Guide</i> guide and <a href="http://docs.aws.amazon.com/mobile/sdkforios/developerguide/cognito-auth.html#d0e664">Amazon Cognito Overview</a> in the <i>AWS SDK for iOS Developer Guide</i>.</p> </note> <p>Calling <code>AssumeRoleWithWebIdentity</code> does not require the use of AWS security credentials. Therefore, you can distribute an application (for example, on mobile devices) that requests temporary security credentials without including long-term AWS credentials in the application, and without deploying server-based proxy services that use long-term AWS credentials. Instead, the identity of the caller is validated by using a token from the web identity provider. For a comparison of <code>AssumeRoleWithWebIdentity</code> with the other APIs that produce temporary credentials, see <a href="http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html">Requesting Temporary Security Credentials</a> and <a href="http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html#stsapi_comparison">Comparing the AWS STS APIs</a> in the <i>IAM User Guide</i>.</p> <p>The temporary security credentials returned by this API consist of an access key ID, a secret access key, and a security token. Applications can use these temporary security credentials to sign calls to AWS service APIs.</p> <p>The credentials are valid for the duration that you specified when calling <code>AssumeRoleWithWebIdentity</code>, which can be from 900 seconds (15 minutes) to a maximum of 3600 seconds (1 hour). The default is 1 hour. </p> <p>The temporary security credentials created by <code>AssumeRoleWithWebIdentity</code> can be used to make API calls to any AWS service with the following exception: you cannot call the STS service's <code>GetFederationToken</code> or <code>GetSessionToken</code> APIs.</p> <p>Optionally, you can pass an IAM access policy to this operation. If you choose not to pass a policy, the temporary security credentials that are returned by the operation have the permissions that are defined in the access policy of the role that is being assumed. If you pass a policy to this operation, the temporary security credentials that are returned by the operation have the permissions that are allowed by both the access policy of the role that is being assumed, <i> <b>and</b> </i> the policy that you pass. This gives you a way to further restrict the permissions for the resulting temporary security credentials. You cannot use the passed policy to grant permissions that are in excess of those allowed by the access policy of the role that is being assumed. For more information, see <a href="http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_control-access_assumerole.html">Permissions for AssumeRole, AssumeRoleWithSAML, and AssumeRoleWithWebIdentity</a> in the <i>IAM User Guide</i>.</p> <p>Before your application can call <code>AssumeRoleWithWebIdentity</code>, you must have an identity token from a supported identity provider and create a role that the application can assume. The role that your application assumes must trust the identity provider that is associated with the identity token. In other words, the identity provider must be specified in the role's trust policy. </p> <important> <p>Calling <code>AssumeRoleWithWebIdentity</code> can result in an entry in your AWS CloudTrail logs. The entry includes the <a href="http://openid.net/specs/openid-connect-core-1_0.html#Claims">Subject</a> of the provided Web Identity Token. We recommend that you avoid using any personally identifiable information (PII) in this field. For example, you could instead use a GUID or a pairwise identifier, as <a href="http://openid.net/specs/openid-connect-core-1_0.html#SubjectIDTypes">suggested in the OIDC specification</a>.</p> </important> <p>For more information about how to use web identity federation and the <code>AssumeRoleWithWebIdentity</code> API, see the following resources: </p> <ul> <li> <p> <a href="http://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_oidc_manual.html">Using Web Identity Federation APIs for Mobile Apps</a> and <a href="http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html#api_assumerolewithwebidentity">Federation Through a Web-based Identity Provider</a>. </p> </li> <li> <p> <a href="https://web-identity-federation-playground.s3.amazonaws.com/index.html"> Web Identity Federation Playground</a>. This interactive website lets you walk through the process of authenticating via Login with Amazon, Facebook, or Google, getting temporary security credentials, and then using those credentials to make a request to AWS. </p> </li> <li> <p> <a href="http://aws.amazon.com/sdkforios/">AWS SDK for iOS</a> and <a href="http://aws.amazon.com/sdkforandroid/">AWS SDK for Android</a>. These toolkits contain sample apps that show how to invoke the identity providers, and then how to use the information from these providers to get and use temporary security credentials. </p> </li> <li> <p> <a href="http://aws.amazon.com/articles/web-identity-federation-with-mobile-applications">Web Identity Federation with Mobile Applications</a>. This article discusses web identity federation and shows an example of how to use web identity federation to get access to content in Amazon S3. </p> </li> </ul>
assumeRoleWithWebIdentity :: forall eff. AssumeRoleWithWebIdentityRequest -> Aff (err :: AWS.RequestError | eff) AssumeRoleWithWebIdentityResponse
assumeRoleWithWebIdentity = AWS.request serviceName "assumeRoleWithWebIdentity" 


-- | <p>Decodes additional information about the authorization status of a request from an encoded message returned in response to an AWS request.</p> <p>For example, if a user is not authorized to perform an action that he or she has requested, the request returns a <code>Client.UnauthorizedOperation</code> response (an HTTP 403 response). Some AWS actions additionally return an encoded message that can provide details about this authorization failure. </p> <note> <p>Only certain AWS actions return an encoded authorization message. The documentation for an individual action indicates whether that action returns an encoded message in addition to returning an HTTP code.</p> </note> <p>The message is encoded because the details of the authorization status can constitute privileged information that the user who requested the action should not see. To decode an authorization status message, a user must be granted permissions via an IAM policy to request the <code>DecodeAuthorizationMessage</code> (<code>sts:DecodeAuthorizationMessage</code>) action. </p> <p>The decoded message includes the following type of information:</p> <ul> <li> <p>Whether the request was denied due to an explicit deny or due to the absence of an explicit allow. For more information, see <a href="http://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_evaluation-logic.html#policy-eval-denyallow">Determining Whether a Request is Allowed or Denied</a> in the <i>IAM User Guide</i>. </p> </li> <li> <p>The principal who made the request.</p> </li> <li> <p>The requested action.</p> </li> <li> <p>The requested resource.</p> </li> <li> <p>The values of condition keys in the context of the user's request.</p> </li> </ul>
decodeAuthorizationMessage :: forall eff. DecodeAuthorizationMessageRequest -> Aff (err :: AWS.RequestError | eff) DecodeAuthorizationMessageResponse
decodeAuthorizationMessage = AWS.request serviceName "decodeAuthorizationMessage" 


-- | <p>Returns details about the IAM identity whose credentials are used to call the API.</p>
getCallerIdentity :: forall eff. GetCallerIdentityRequest -> Aff (err :: AWS.RequestError | eff) GetCallerIdentityResponse
getCallerIdentity = AWS.request serviceName "getCallerIdentity" 


-- | <p>Returns a set of temporary security credentials (consisting of an access key ID, a secret access key, and a security token) for a federated user. A typical use is in a proxy application that gets temporary security credentials on behalf of distributed applications inside a corporate network. Because you must call the <code>GetFederationToken</code> action using the long-term security credentials of an IAM user, this call is appropriate in contexts where those credentials can be safely stored, usually in a server-based application. For a comparison of <code>GetFederationToken</code> with the other APIs that produce temporary credentials, see <a href="http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html">Requesting Temporary Security Credentials</a> and <a href="http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html#stsapi_comparison">Comparing the AWS STS APIs</a> in the <i>IAM User Guide</i>.</p> <note> <p>If you are creating a mobile-based or browser-based app that can authenticate users using a web identity provider like Login with Amazon, Facebook, Google, or an OpenID Connect-compatible identity provider, we recommend that you use <a href="http://aws.amazon.com/cognito/">Amazon Cognito</a> or <code>AssumeRoleWithWebIdentity</code>. For more information, see <a href="http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html#api_assumerolewithwebidentity">Federation Through a Web-based Identity Provider</a>.</p> </note> <p>The <code>GetFederationToken</code> action must be called by using the long-term AWS security credentials of an IAM user. You can also call <code>GetFederationToken</code> using the security credentials of an AWS root account, but we do not recommended it. Instead, we recommend that you create an IAM user for the purpose of the proxy application and then attach a policy to the IAM user that limits federated users to only the actions and resources that they need access to. For more information, see <a href="http://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html">IAM Best Practices</a> in the <i>IAM User Guide</i>. </p> <p>The temporary security credentials that are obtained by using the long-term credentials of an IAM user are valid for the specified duration, from 900 seconds (15 minutes) up to a maximium of 129600 seconds (36 hours). The default is 43200 seconds (12 hours). Temporary credentials that are obtained by using AWS root account credentials have a maximum duration of 3600 seconds (1 hour).</p> <p>The temporary security credentials created by <code>GetFederationToken</code> can be used to make API calls to any AWS service with the following exceptions:</p> <ul> <li> <p>You cannot use these credentials to call any IAM APIs.</p> </li> <li> <p>You cannot call any STS APIs except <code>GetCallerIdentity</code>.</p> </li> </ul> <p> <b>Permissions</b> </p> <p>The permissions for the temporary security credentials returned by <code>GetFederationToken</code> are determined by a combination of the following: </p> <ul> <li> <p>The policy or policies that are attached to the IAM user whose credentials are used to call <code>GetFederationToken</code>.</p> </li> <li> <p>The policy that is passed as a parameter in the call.</p> </li> </ul> <p>The passed policy is attached to the temporary security credentials that result from the <code>GetFederationToken</code> API call--that is, to the <i>federated user</i>. When the federated user makes an AWS request, AWS evaluates the policy attached to the federated user in combination with the policy or policies attached to the IAM user whose credentials were used to call <code>GetFederationToken</code>. AWS allows the federated user's request only when both the federated user <i> <b>and</b> </i> the IAM user are explicitly allowed to perform the requested action. The passed policy cannot grant more permissions than those that are defined in the IAM user policy.</p> <p>A typical use case is that the permissions of the IAM user whose credentials are used to call <code>GetFederationToken</code> are designed to allow access to all the actions and resources that any federated user will need. Then, for individual users, you pass a policy to the operation that scopes down the permissions to a level that's appropriate to that individual user, using a policy that allows only a subset of permissions that are granted to the IAM user. </p> <p>If you do not pass a policy, the resulting temporary security credentials have no effective permissions. The only exception is when the temporary security credentials are used to access a resource that has a resource-based policy that specifically allows the federated user to access the resource.</p> <p>For more information about how permissions work, see <a href="http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_control-access_getfederationtoken.html">Permissions for GetFederationToken</a>. For information about using <code>GetFederationToken</code> to create temporary security credentials, see <a href="http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html#api_getfederationtoken">GetFederationToken—Federation Through a Custom Identity Broker</a>. </p>
getFederationToken :: forall eff. GetFederationTokenRequest -> Aff (err :: AWS.RequestError | eff) GetFederationTokenResponse
getFederationToken = AWS.request serviceName "getFederationToken" 


-- | <p>Returns a set of temporary credentials for an AWS account or IAM user. The credentials consist of an access key ID, a secret access key, and a security token. Typically, you use <code>GetSessionToken</code> if you want to use MFA to protect programmatic calls to specific AWS APIs like Amazon EC2 <code>StopInstances</code>. MFA-enabled IAM users would need to call <code>GetSessionToken</code> and submit an MFA code that is associated with their MFA device. Using the temporary security credentials that are returned from the call, IAM users can then make programmatic calls to APIs that require MFA authentication. If you do not supply a correct MFA code, then the API returns an access denied error. For a comparison of <code>GetSessionToken</code> with the other APIs that produce temporary credentials, see <a href="http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html">Requesting Temporary Security Credentials</a> and <a href="http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html#stsapi_comparison">Comparing the AWS STS APIs</a> in the <i>IAM User Guide</i>.</p> <p>The <code>GetSessionToken</code> action must be called by using the long-term AWS security credentials of the AWS account or an IAM user. Credentials that are created by IAM users are valid for the duration that you specify, from 900 seconds (15 minutes) up to a maximum of 129600 seconds (36 hours), with a default of 43200 seconds (12 hours); credentials that are created by using account credentials can range from 900 seconds (15 minutes) up to a maximum of 3600 seconds (1 hour), with a default of 1 hour. </p> <p>The temporary security credentials created by <code>GetSessionToken</code> can be used to make API calls to any AWS service with the following exceptions:</p> <ul> <li> <p>You cannot call any IAM APIs unless MFA authentication information is included in the request.</p> </li> <li> <p>You cannot call any STS API <i>except</i> <code>AssumeRole</code> or <code>GetCallerIdentity</code>.</p> </li> </ul> <note> <p>We recommend that you do not call <code>GetSessionToken</code> with root account credentials. Instead, follow our <a href="http://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html#create-iam-users">best practices</a> by creating one or more IAM users, giving them the necessary permissions, and using IAM users for everyday interaction with AWS. </p> </note> <p>The permissions associated with the temporary security credentials returned by <code>GetSessionToken</code> are based on the permissions associated with account or IAM user whose credentials are used to call the action. If <code>GetSessionToken</code> is called using root account credentials, the temporary credentials have root account permissions. Similarly, if <code>GetSessionToken</code> is called using the credentials of an IAM user, the temporary credentials have the same permissions as the IAM user. </p> <p>For more information about using <code>GetSessionToken</code> to create temporary credentials, go to <a href="http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html#api_getsessiontoken">Temporary Credentials for Users in Untrusted Environments</a> in the <i>IAM User Guide</i>. </p>
getSessionToken :: forall eff. GetSessionTokenRequest -> Aff (err :: AWS.RequestError | eff) GetSessionTokenResponse
getSessionToken = AWS.request serviceName "getSessionToken" 


newtype AssumeRoleRequest = AssumeRoleRequest 
  { "RoleArn" :: (ArnType')
  , "RoleSessionName" :: (RoleSessionNameType')
  , "Policy" :: NullOrUndefined (SessionPolicyDocumentType')
  , "DurationSeconds" :: NullOrUndefined (RoleDurationSecondsType')
  , "ExternalId" :: NullOrUndefined (ExternalIdType')
  , "SerialNumber" :: NullOrUndefined (SerialNumberType')
  , "TokenCode" :: NullOrUndefined (TokenCodeType')
  }
derive instance newtypeAssumeRoleRequest :: Newtype AssumeRoleRequest _


-- | <p>Contains the response to a successful <a>AssumeRole</a> request, including temporary AWS credentials that can be used to make AWS requests. </p>
newtype AssumeRoleResponse = AssumeRoleResponse 
  { "Credentials" :: NullOrUndefined (Credentials)
  , "AssumedRoleUser" :: NullOrUndefined (AssumedRoleUser)
  , "PackedPolicySize" :: NullOrUndefined (NonNegativeIntegerType')
  }
derive instance newtypeAssumeRoleResponse :: Newtype AssumeRoleResponse _


newtype AssumeRoleWithSAMLRequest = AssumeRoleWithSAMLRequest 
  { "RoleArn" :: (ArnType')
  , "PrincipalArn" :: (ArnType')
  , "SAMLAssertion" :: (SAMLAssertionType)
  , "Policy" :: NullOrUndefined (SessionPolicyDocumentType')
  , "DurationSeconds" :: NullOrUndefined (RoleDurationSecondsType')
  }
derive instance newtypeAssumeRoleWithSAMLRequest :: Newtype AssumeRoleWithSAMLRequest _


-- | <p>Contains the response to a successful <a>AssumeRoleWithSAML</a> request, including temporary AWS credentials that can be used to make AWS requests. </p>
newtype AssumeRoleWithSAMLResponse = AssumeRoleWithSAMLResponse 
  { "Credentials" :: NullOrUndefined (Credentials)
  , "AssumedRoleUser" :: NullOrUndefined (AssumedRoleUser)
  , "PackedPolicySize" :: NullOrUndefined (NonNegativeIntegerType')
  , "Subject" :: NullOrUndefined (Subject)
  , "SubjectType" :: NullOrUndefined (SubjectType)
  , "Issuer" :: NullOrUndefined (Issuer)
  , "Audience" :: NullOrUndefined (Audience)
  , "NameQualifier" :: NullOrUndefined (NameQualifier)
  }
derive instance newtypeAssumeRoleWithSAMLResponse :: Newtype AssumeRoleWithSAMLResponse _


newtype AssumeRoleWithWebIdentityRequest = AssumeRoleWithWebIdentityRequest 
  { "RoleArn" :: (ArnType')
  , "RoleSessionName" :: (RoleSessionNameType')
  , "WebIdentityToken" :: (ClientTokenType')
  , "ProviderId" :: NullOrUndefined (UrlType')
  , "Policy" :: NullOrUndefined (SessionPolicyDocumentType')
  , "DurationSeconds" :: NullOrUndefined (RoleDurationSecondsType')
  }
derive instance newtypeAssumeRoleWithWebIdentityRequest :: Newtype AssumeRoleWithWebIdentityRequest _


-- | <p>Contains the response to a successful <a>AssumeRoleWithWebIdentity</a> request, including temporary AWS credentials that can be used to make AWS requests. </p>
newtype AssumeRoleWithWebIdentityResponse = AssumeRoleWithWebIdentityResponse 
  { "Credentials" :: NullOrUndefined (Credentials)
  , "SubjectFromWebIdentityToken" :: NullOrUndefined (WebIdentitySubjectType')
  , "AssumedRoleUser" :: NullOrUndefined (AssumedRoleUser)
  , "PackedPolicySize" :: NullOrUndefined (NonNegativeIntegerType')
  , "Provider" :: NullOrUndefined (Issuer)
  , "Audience" :: NullOrUndefined (Audience)
  }
derive instance newtypeAssumeRoleWithWebIdentityResponse :: Newtype AssumeRoleWithWebIdentityResponse _


-- | <p>The identifiers for the temporary security credentials that the operation returns.</p>
newtype AssumedRoleUser = AssumedRoleUser 
  { "AssumedRoleId" :: (AssumedRoleIdType')
  , "Arn" :: (ArnType')
  }
derive instance newtypeAssumedRoleUser :: Newtype AssumedRoleUser _


newtype Audience = Audience String
derive instance newtypeAudience :: Newtype Audience _


-- | <p>AWS credentials for API authentication.</p>
newtype Credentials = Credentials 
  { "AccessKeyId" :: (AccessKeyIdType')
  , "SecretAccessKey" :: (AccessKeySecretType')
  , "SessionToken" :: (TokenType')
  , "Expiration" :: (DateType')
  }
derive instance newtypeCredentials :: Newtype Credentials _


newtype DecodeAuthorizationMessageRequest = DecodeAuthorizationMessageRequest 
  { "EncodedMessage" :: (EncodedMessageType')
  }
derive instance newtypeDecodeAuthorizationMessageRequest :: Newtype DecodeAuthorizationMessageRequest _


-- | <p>A document that contains additional information about the authorization status of a request from an encoded message that is returned in response to an AWS request.</p>
newtype DecodeAuthorizationMessageResponse = DecodeAuthorizationMessageResponse 
  { "DecodedMessage" :: NullOrUndefined (DecodedMessageType')
  }
derive instance newtypeDecodeAuthorizationMessageResponse :: Newtype DecodeAuthorizationMessageResponse _


-- | <p>The web identity token that was passed is expired or is not valid. Get a new identity token from the identity provider and then retry the request.</p>
newtype ExpiredTokenException = ExpiredTokenException 
  { "Message'" :: NullOrUndefined (ExpiredIdentityTokenMessage')
  }
derive instance newtypeExpiredTokenException :: Newtype ExpiredTokenException _


-- | <p>Identifiers for the federated user that is associated with the credentials.</p>
newtype FederatedUser = FederatedUser 
  { "FederatedUserId" :: (FederatedIdType')
  , "Arn" :: (ArnType')
  }
derive instance newtypeFederatedUser :: Newtype FederatedUser _


newtype GetCallerIdentityRequest = GetCallerIdentityRequest 
  { 
  }
derive instance newtypeGetCallerIdentityRequest :: Newtype GetCallerIdentityRequest _


-- | <p>Contains the response to a successful <a>GetCallerIdentity</a> request, including information about the entity making the request.</p>
newtype GetCallerIdentityResponse = GetCallerIdentityResponse 
  { "UserId" :: NullOrUndefined (UserIdType')
  , "Account" :: NullOrUndefined (AccountType')
  , "Arn" :: NullOrUndefined (ArnType')
  }
derive instance newtypeGetCallerIdentityResponse :: Newtype GetCallerIdentityResponse _


newtype GetFederationTokenRequest = GetFederationTokenRequest 
  { "Name" :: (UserNameType')
  , "Policy" :: NullOrUndefined (SessionPolicyDocumentType')
  , "DurationSeconds" :: NullOrUndefined (DurationSecondsType')
  }
derive instance newtypeGetFederationTokenRequest :: Newtype GetFederationTokenRequest _


-- | <p>Contains the response to a successful <a>GetFederationToken</a> request, including temporary AWS credentials that can be used to make AWS requests. </p>
newtype GetFederationTokenResponse = GetFederationTokenResponse 
  { "Credentials" :: NullOrUndefined (Credentials)
  , "FederatedUser" :: NullOrUndefined (FederatedUser)
  , "PackedPolicySize" :: NullOrUndefined (NonNegativeIntegerType')
  }
derive instance newtypeGetFederationTokenResponse :: Newtype GetFederationTokenResponse _


newtype GetSessionTokenRequest = GetSessionTokenRequest 
  { "DurationSeconds" :: NullOrUndefined (DurationSecondsType')
  , "SerialNumber" :: NullOrUndefined (SerialNumberType')
  , "TokenCode" :: NullOrUndefined (TokenCodeType')
  }
derive instance newtypeGetSessionTokenRequest :: Newtype GetSessionTokenRequest _


-- | <p>Contains the response to a successful <a>GetSessionToken</a> request, including temporary AWS credentials that can be used to make AWS requests. </p>
newtype GetSessionTokenResponse = GetSessionTokenResponse 
  { "Credentials" :: NullOrUndefined (Credentials)
  }
derive instance newtypeGetSessionTokenResponse :: Newtype GetSessionTokenResponse _


-- | <p>The request could not be fulfilled because the non-AWS identity provider (IDP) that was asked to verify the incoming identity token could not be reached. This is often a transient error caused by network conditions. Retry the request a limited number of times so that you don't exceed the request rate. If the error persists, the non-AWS identity provider might be down or not responding.</p>
newtype IDPCommunicationErrorException = IDPCommunicationErrorException 
  { "Message'" :: NullOrUndefined (IdpCommunicationErrorMessage')
  }
derive instance newtypeIDPCommunicationErrorException :: Newtype IDPCommunicationErrorException _


-- | <p>The identity provider (IdP) reported that authentication failed. This might be because the claim is invalid.</p> <p>If this error is returned for the <code>AssumeRoleWithWebIdentity</code> operation, it can also mean that the claim has expired or has been explicitly revoked. </p>
newtype IDPRejectedClaimException = IDPRejectedClaimException 
  { "Message'" :: NullOrUndefined (IdpRejectedClaimMessage')
  }
derive instance newtypeIDPRejectedClaimException :: Newtype IDPRejectedClaimException _


-- | <p>The error returned if the message passed to <code>DecodeAuthorizationMessage</code> was invalid. This can happen if the token contains invalid characters, such as linebreaks. </p>
newtype InvalidAuthorizationMessageException = InvalidAuthorizationMessageException 
  { "Message'" :: NullOrUndefined (InvalidAuthorizationMessage')
  }
derive instance newtypeInvalidAuthorizationMessageException :: Newtype InvalidAuthorizationMessageException _


-- | <p>The web identity token that was passed could not be validated by AWS. Get a new identity token from the identity provider and then retry the request.</p>
newtype InvalidIdentityTokenException = InvalidIdentityTokenException 
  { "Message'" :: NullOrUndefined (InvalidIdentityTokenMessage')
  }
derive instance newtypeInvalidIdentityTokenException :: Newtype InvalidIdentityTokenException _


newtype Issuer = Issuer String
derive instance newtypeIssuer :: Newtype Issuer _


-- | <p>The request was rejected because the policy document was malformed. The error message describes the specific error.</p>
newtype MalformedPolicyDocumentException = MalformedPolicyDocumentException 
  { "Message'" :: NullOrUndefined (MalformedPolicyDocumentMessage')
  }
derive instance newtypeMalformedPolicyDocumentException :: Newtype MalformedPolicyDocumentException _


newtype NameQualifier = NameQualifier String
derive instance newtypeNameQualifier :: Newtype NameQualifier _


-- | <p>The request was rejected because the policy document was too large. The error message describes how big the policy document is, in packed form, as a percentage of what the API allows.</p>
newtype PackedPolicyTooLargeException = PackedPolicyTooLargeException 
  { "Message'" :: NullOrUndefined (PackedPolicyTooLargeMessage')
  }
derive instance newtypePackedPolicyTooLargeException :: Newtype PackedPolicyTooLargeException _


-- | <p>STS is not activated in the requested region for the account that is being asked to generate credentials. The account administrator must use the IAM console to activate STS in that region. For more information, see <a href="http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_enable-regions.html">Activating and Deactivating AWS STS in an AWS Region</a> in the <i>IAM User Guide</i>.</p>
newtype RegionDisabledException = RegionDisabledException 
  { "Message'" :: NullOrUndefined (RegionDisabledMessage')
  }
derive instance newtypeRegionDisabledException :: Newtype RegionDisabledException _


newtype SAMLAssertionType = SAMLAssertionType String
derive instance newtypeSAMLAssertionType :: Newtype SAMLAssertionType _


newtype Subject = Subject String
derive instance newtypeSubject :: Newtype Subject _


newtype SubjectType = SubjectType String
derive instance newtypeSubjectType :: Newtype SubjectType _


newtype AccessKeyIdType' = AccessKeyIdType' String
derive instance newtypeAccessKeyIdType' :: Newtype AccessKeyIdType' _


newtype AccessKeySecretType' = AccessKeySecretType' String
derive instance newtypeAccessKeySecretType' :: Newtype AccessKeySecretType' _


newtype AccountType' = AccountType' String
derive instance newtypeAccountType' :: Newtype AccountType' _


newtype ArnType' = ArnType' String
derive instance newtypeArnType' :: Newtype ArnType' _


newtype AssumedRoleIdType' = AssumedRoleIdType' String
derive instance newtypeAssumedRoleIdType' :: Newtype AssumedRoleIdType' _


newtype ClientTokenType' = ClientTokenType' String
derive instance newtypeClientTokenType' :: Newtype ClientTokenType' _


newtype DateType' = DateType' Number
derive instance newtypeDateType' :: Newtype DateType' _


newtype DecodedMessageType' = DecodedMessageType' String
derive instance newtypeDecodedMessageType' :: Newtype DecodedMessageType' _


newtype DurationSecondsType' = DurationSecondsType' Int
derive instance newtypeDurationSecondsType' :: Newtype DurationSecondsType' _


newtype EncodedMessageType' = EncodedMessageType' String
derive instance newtypeEncodedMessageType' :: Newtype EncodedMessageType' _


newtype ExpiredIdentityTokenMessage' = ExpiredIdentityTokenMessage' String
derive instance newtypeExpiredIdentityTokenMessage' :: Newtype ExpiredIdentityTokenMessage' _


newtype ExternalIdType' = ExternalIdType' String
derive instance newtypeExternalIdType' :: Newtype ExternalIdType' _


newtype FederatedIdType' = FederatedIdType' String
derive instance newtypeFederatedIdType' :: Newtype FederatedIdType' _


newtype IdpCommunicationErrorMessage' = IdpCommunicationErrorMessage' String
derive instance newtypeIdpCommunicationErrorMessage' :: Newtype IdpCommunicationErrorMessage' _


newtype IdpRejectedClaimMessage' = IdpRejectedClaimMessage' String
derive instance newtypeIdpRejectedClaimMessage' :: Newtype IdpRejectedClaimMessage' _


newtype InvalidAuthorizationMessage' = InvalidAuthorizationMessage' String
derive instance newtypeInvalidAuthorizationMessage' :: Newtype InvalidAuthorizationMessage' _


newtype InvalidIdentityTokenMessage' = InvalidIdentityTokenMessage' String
derive instance newtypeInvalidIdentityTokenMessage' :: Newtype InvalidIdentityTokenMessage' _


newtype MalformedPolicyDocumentMessage' = MalformedPolicyDocumentMessage' String
derive instance newtypeMalformedPolicyDocumentMessage' :: Newtype MalformedPolicyDocumentMessage' _


newtype NonNegativeIntegerType' = NonNegativeIntegerType' Int
derive instance newtypeNonNegativeIntegerType' :: Newtype NonNegativeIntegerType' _


newtype PackedPolicyTooLargeMessage' = PackedPolicyTooLargeMessage' String
derive instance newtypePackedPolicyTooLargeMessage' :: Newtype PackedPolicyTooLargeMessage' _


newtype RegionDisabledMessage' = RegionDisabledMessage' String
derive instance newtypeRegionDisabledMessage' :: Newtype RegionDisabledMessage' _


newtype RoleDurationSecondsType' = RoleDurationSecondsType' Int
derive instance newtypeRoleDurationSecondsType' :: Newtype RoleDurationSecondsType' _


newtype RoleSessionNameType' = RoleSessionNameType' String
derive instance newtypeRoleSessionNameType' :: Newtype RoleSessionNameType' _


newtype SerialNumberType' = SerialNumberType' String
derive instance newtypeSerialNumberType' :: Newtype SerialNumberType' _


newtype SessionPolicyDocumentType' = SessionPolicyDocumentType' String
derive instance newtypeSessionPolicyDocumentType' :: Newtype SessionPolicyDocumentType' _


newtype TokenCodeType' = TokenCodeType' String
derive instance newtypeTokenCodeType' :: Newtype TokenCodeType' _


newtype TokenType' = TokenType' String
derive instance newtypeTokenType' :: Newtype TokenType' _


newtype UrlType' = UrlType' String
derive instance newtypeUrlType' :: Newtype UrlType' _


newtype UserIdType' = UserIdType' String
derive instance newtypeUserIdType' :: Newtype UserIdType' _


newtype UserNameType' = UserNameType' String
derive instance newtypeUserNameType' :: Newtype UserNameType' _


newtype WebIdentitySubjectType' = WebIdentitySubjectType' String
derive instance newtypeWebIdentitySubjectType' :: Newtype WebIdentitySubjectType' _
