## Module AWS.ImportExport

<fullname>AWS Import/Export Service</fullname> AWS Import/Export accelerates transferring large amounts of data between the AWS cloud and portable storage devices that you mail to us. AWS Import/Export transfers data directly onto and off of your storage devices using Amazon's high-speed internal network and bypassing the Internet. For large data sets, AWS Import/Export is often faster than Internet transfer and more cost effective than upgrading your connectivity.

#### `serviceName`

``` purescript
serviceName :: String
```

#### `cancelJob`

``` purescript
cancelJob :: forall eff. CancelJobInput -> Aff (err :: RequestError | eff) CancelJobOutput
```

This operation cancels a specified job. Only the job owner can cancel it. The operation fails if the job has already started or is complete.

#### `createJob`

``` purescript
createJob :: forall eff. CreateJobInput -> Aff (err :: RequestError | eff) CreateJobOutput
```

This operation initiates the process of scheduling an upload or download of your data. You include in the request a manifest that describes the data transfer specifics. The response to the request includes a job ID, which you can use in other operations, a signature that you use to identify your storage device, and the address where you should ship your storage device.

#### `getShippingLabel`

``` purescript
getShippingLabel :: forall eff. GetShippingLabelInput -> Aff (err :: RequestError | eff) GetShippingLabelOutput
```

This operation generates a pre-paid UPS shipping label that you will use to ship your device to AWS for processing.

#### `getStatus`

``` purescript
getStatus :: forall eff. GetStatusInput -> Aff (err :: RequestError | eff) GetStatusOutput
```

This operation returns information about a job, including where the job is in the processing pipeline, the status of the results, and the signature value associated with the job. You can only return information about jobs you own.

#### `listJobs`

``` purescript
listJobs :: forall eff. ListJobsInput -> Aff (err :: RequestError | eff) ListJobsOutput
```

This operation returns the jobs associated with the requester. AWS Import/Export lists the jobs in reverse chronological order based on the date of creation. For example if Job Test1 was created 2009Dec30 and Test2 was created 2010Feb05, the ListJobs operation would return Test2 followed by Test1.

#### `updateJob`

``` purescript
updateJob :: forall eff. UpdateJobInput -> Aff (err :: RequestError | eff) UpdateJobOutput
```

You use this operation to change the parameters specified in the original manifest file by supplying a new manifest file. The manifest file attached to this request replaces the original manifest file. You can only use the operation after a CreateJob request but before the data transfer starts and you can only use it on jobs you own.

#### `APIVersion`

``` purescript
newtype APIVersion
  = APIVersion String
```

Specifies the version of the client tool.

#### `Artifact`

``` purescript
newtype Artifact
  = Artifact { "Description" :: NullOrUndefined (Description), "URL" :: NullOrUndefined (URL) }
```

A discrete item that contains the description and URL of an artifact (such as a PDF).

#### `ArtifactList`

``` purescript
newtype ArtifactList
  = ArtifactList (Array Artifact)
```

A collection of artifacts.

#### `BucketPermissionException`

``` purescript
newtype BucketPermissionException
  = BucketPermissionException { "Message'" :: NullOrUndefined (ErrorMessage) }
```

The account specified does not have the appropriate bucket permissions.

#### `CancelJobInput`

``` purescript
newtype CancelJobInput
  = CancelJobInput { "JobId" :: JobId, "APIVersion" :: NullOrUndefined (APIVersion) }
```

Input structure for the CancelJob operation.

#### `CancelJobOutput`

``` purescript
newtype CancelJobOutput
  = CancelJobOutput { "Success" :: NullOrUndefined (Success) }
```

Output structure for the CancelJob operation.

#### `CanceledJobIdException`

``` purescript
newtype CanceledJobIdException
  = CanceledJobIdException { "Message'" :: NullOrUndefined (ErrorMessage) }
```

The specified job ID has been canceled and is no longer valid.

#### `Carrier`

``` purescript
newtype Carrier
  = Carrier String
```

Name of the shipping company. This value is included when the LocationCode is "Returned".

#### `CreateJobInput`

``` purescript
newtype CreateJobInput
  = CreateJobInput { "JobType" :: JobType, "Manifest" :: Manifest, "ManifestAddendum" :: NullOrUndefined (ManifestAddendum), "ValidateOnly" :: ValidateOnly, "APIVersion" :: NullOrUndefined (APIVersion) }
```

Input structure for the CreateJob operation.

#### `CreateJobOutput`

``` purescript
newtype CreateJobOutput
  = CreateJobOutput { "JobId" :: NullOrUndefined (JobId), "JobType" :: NullOrUndefined (JobType), "Signature" :: NullOrUndefined (Signature), "SignatureFileContents" :: NullOrUndefined (SignatureFileContents), "WarningMessage" :: NullOrUndefined (WarningMessage), "ArtifactList" :: NullOrUndefined (ArtifactList) }
```

Output structure for the CreateJob operation.

#### `CreateJobQuotaExceededException`

``` purescript
newtype CreateJobQuotaExceededException
  = CreateJobQuotaExceededException { "Message'" :: NullOrUndefined (ErrorMessage) }
```

Each account can create only a certain number of jobs per day. If you need to create more than this, please contact awsimportexport@amazon.com to explain your particular use case.

#### `CreationDate`

``` purescript
newtype CreationDate
  = CreationDate Number
```

Timestamp of the CreateJob request in ISO8601 date format. For example "2010-03-28T20:27:35Z".

#### `CurrentManifest`

``` purescript
newtype CurrentManifest
  = CurrentManifest String
```

The last manifest submitted, which will be used to process the job.

#### `Description`

``` purescript
newtype Description
  = Description String
```

The associated description for this object.

#### `ErrorCount`

``` purescript
newtype ErrorCount
  = ErrorCount Int
```

Number of errors. We return this value when the ProgressCode is Success or SuccessWithErrors.

#### `ErrorMessage`

``` purescript
newtype ErrorMessage
  = ErrorMessage String
```

The human-readable description of a particular error.

#### `ExpiredJobIdException`

``` purescript
newtype ExpiredJobIdException
  = ExpiredJobIdException { "Message'" :: NullOrUndefined (ErrorMessage) }
```

Indicates that the specified job has expired out of the system.

#### `GenericString`

``` purescript
newtype GenericString
  = GenericString String
```

#### `GetShippingLabelInput`

``` purescript
newtype GetShippingLabelInput
  = GetShippingLabelInput { "JobIds'" :: JobIdList, "Name'" :: NullOrUndefined (Name'), "Company'" :: NullOrUndefined (Company'), "PhoneNumber'" :: NullOrUndefined (PhoneNumber'), "Country'" :: NullOrUndefined (Country'), "StateOrProvince'" :: NullOrUndefined (StateOrProvince'), "City'" :: NullOrUndefined (City'), "PostalCode'" :: NullOrUndefined (PostalCode'), "Street1'" :: NullOrUndefined (Street1'), "Street2'" :: NullOrUndefined (Street2'), "Street3'" :: NullOrUndefined (Street3'), "APIVersion" :: NullOrUndefined (APIVersion) }
```

#### `GetShippingLabelOutput`

``` purescript
newtype GetShippingLabelOutput
  = GetShippingLabelOutput { "ShippingLabelURL" :: NullOrUndefined (GenericString), "Warning" :: NullOrUndefined (GenericString) }
```

#### `GetStatusInput`

``` purescript
newtype GetStatusInput
  = GetStatusInput { "JobId" :: JobId, "APIVersion" :: NullOrUndefined (APIVersion) }
```

Input structure for the GetStatus operation.

#### `GetStatusOutput`

``` purescript
newtype GetStatusOutput
  = GetStatusOutput { "JobId" :: NullOrUndefined (JobId), "JobType" :: NullOrUndefined (JobType), "LocationCode" :: NullOrUndefined (LocationCode), "LocationMessage" :: NullOrUndefined (LocationMessage), "ProgressCode" :: NullOrUndefined (ProgressCode), "ProgressMessage" :: NullOrUndefined (ProgressMessage), "Carrier" :: NullOrUndefined (Carrier), "TrackingNumber" :: NullOrUndefined (TrackingNumber), "LogBucket" :: NullOrUndefined (LogBucket), "LogKey" :: NullOrUndefined (LogKey), "ErrorCount" :: NullOrUndefined (ErrorCount), "Signature" :: NullOrUndefined (Signature), "SignatureFileContents" :: NullOrUndefined (Signature), "CurrentManifest" :: NullOrUndefined (CurrentManifest), "CreationDate" :: NullOrUndefined (CreationDate), "ArtifactList" :: NullOrUndefined (ArtifactList) }
```

Output structure for the GetStatus operation.

#### `InvalidAccessKeyIdException`

``` purescript
newtype InvalidAccessKeyIdException
  = InvalidAccessKeyIdException { "Message'" :: NullOrUndefined (ErrorMessage) }
```

The AWS Access Key ID specified in the request did not match the manifest's accessKeyId value. The manifest and the request authentication must use the same AWS Access Key ID.

#### `InvalidAddressException`

``` purescript
newtype InvalidAddressException
  = InvalidAddressException { "Message'" :: NullOrUndefined (ErrorMessage) }
```

The address specified in the manifest is invalid.

#### `InvalidCustomsException`

``` purescript
newtype InvalidCustomsException
  = InvalidCustomsException { "Message'" :: NullOrUndefined (ErrorMessage) }
```

One or more customs parameters was invalid. Please correct and resubmit.

#### `InvalidFileSystemException`

``` purescript
newtype InvalidFileSystemException
  = InvalidFileSystemException { "Message'" :: NullOrUndefined (ErrorMessage) }
```

File system specified in export manifest is invalid.

#### `InvalidJobIdException`

``` purescript
newtype InvalidJobIdException
  = InvalidJobIdException { "Message'" :: NullOrUndefined (ErrorMessage) }
```

The JOBID was missing, not found, or not associated with the AWS account.

#### `InvalidManifestFieldException`

``` purescript
newtype InvalidManifestFieldException
  = InvalidManifestFieldException { "Message'" :: NullOrUndefined (ErrorMessage) }
```

One or more manifest fields was invalid. Please correct and resubmit.

#### `InvalidParameterException`

``` purescript
newtype InvalidParameterException
  = InvalidParameterException { "Message'" :: NullOrUndefined (ErrorMessage) }
```

One or more parameters had an invalid value.

#### `InvalidVersionException`

``` purescript
newtype InvalidVersionException
  = InvalidVersionException { "Message'" :: NullOrUndefined (ErrorMessage) }
```

The client tool version is invalid.

#### `IsCanceled`

``` purescript
newtype IsCanceled
  = IsCanceled Boolean
```

Indicates whether the job was canceled.

#### `IsTruncated`

``` purescript
newtype IsTruncated
  = IsTruncated Boolean
```

Indicates whether the list of jobs was truncated. If true, then call ListJobs again using the last JobId element as the marker.

#### `Job`

``` purescript
newtype Job
  = Job { "JobId" :: NullOrUndefined (JobId), "CreationDate" :: NullOrUndefined (CreationDate), "IsCanceled" :: NullOrUndefined (IsCanceled), "JobType" :: NullOrUndefined (JobType) }
```

Representation of a job returned by the ListJobs operation.

#### `JobId`

``` purescript
newtype JobId
  = JobId String
```

A unique identifier which refers to a particular job.

#### `JobIdList`

``` purescript
newtype JobIdList
  = JobIdList (Array GenericString)
```

#### `JobType`

``` purescript
newtype JobType
  = JobType String
```

Specifies whether the job to initiate is an import or export job.

#### `JobsList`

``` purescript
newtype JobsList
  = JobsList (Array Job)
```

A list container for Jobs returned by the ListJobs operation.

#### `ListJobsInput`

``` purescript
newtype ListJobsInput
  = ListJobsInput { "MaxJobs" :: NullOrUndefined (MaxJobs), "Marker" :: NullOrUndefined (Marker), "APIVersion" :: NullOrUndefined (APIVersion) }
```

Input structure for the ListJobs operation.

#### `ListJobsOutput`

``` purescript
newtype ListJobsOutput
  = ListJobsOutput { "Jobs" :: NullOrUndefined (JobsList), "IsTruncated" :: NullOrUndefined (IsTruncated) }
```

Output structure for the ListJobs operation.

#### `LocationCode`

``` purescript
newtype LocationCode
  = LocationCode String
```

A token representing the location of the storage device, such as "AtAWS".

#### `LocationMessage`

``` purescript
newtype LocationMessage
  = LocationMessage String
```

A more human readable form of the physical location of the storage device.

#### `LogBucket`

``` purescript
newtype LogBucket
  = LogBucket String
```

Amazon S3 bucket for user logs.

#### `LogKey`

``` purescript
newtype LogKey
  = LogKey String
```

The key where the user logs were stored.

#### `MalformedManifestException`

``` purescript
newtype MalformedManifestException
  = MalformedManifestException { "Message'" :: NullOrUndefined (ErrorMessage) }
```

Your manifest is not well-formed.

#### `Manifest`

``` purescript
newtype Manifest
  = Manifest String
```

The UTF-8 encoded text of the manifest file.

#### `ManifestAddendum`

``` purescript
newtype ManifestAddendum
  = ManifestAddendum String
```

For internal use only.

#### `Marker`

``` purescript
newtype Marker
  = Marker String
```

Specifies the JOBID to start after when listing the jobs created with your account. AWS Import/Export lists your jobs in reverse chronological order. See MaxJobs.

#### `MaxJobs`

``` purescript
newtype MaxJobs
  = MaxJobs Int
```

Sets the maximum number of jobs returned in the response. If there are additional jobs that were not returned because MaxJobs was exceeded, the response contains &lt;IsTruncated&gt;true&lt;/IsTruncated&gt;. To return the additional jobs, see Marker.

#### `MissingCustomsException`

``` purescript
newtype MissingCustomsException
  = MissingCustomsException { "Message'" :: NullOrUndefined (ErrorMessage) }
```

One or more required customs parameters was missing from the manifest.

#### `MissingManifestFieldException`

``` purescript
newtype MissingManifestFieldException
  = MissingManifestFieldException { "Message'" :: NullOrUndefined (ErrorMessage) }
```

One or more required fields were missing from the manifest file. Please correct and resubmit.

#### `MissingParameterException`

``` purescript
newtype MissingParameterException
  = MissingParameterException { "Message'" :: NullOrUndefined (ErrorMessage) }
```

One or more required parameters was missing from the request.

#### `MultipleRegionsException`

``` purescript
newtype MultipleRegionsException
  = MultipleRegionsException { "Message'" :: NullOrUndefined (ErrorMessage) }
```

Your manifest file contained buckets from multiple regions. A job is restricted to buckets from one region. Please correct and resubmit.

#### `NoSuchBucketException`

``` purescript
newtype NoSuchBucketException
  = NoSuchBucketException { "Message'" :: NullOrUndefined (ErrorMessage) }
```

The specified bucket does not exist. Create the specified bucket or change the manifest's bucket, exportBucket, or logBucket field to a bucket that the account, as specified by the manifest's Access Key ID, has write permissions to.

#### `ProgressCode`

``` purescript
newtype ProgressCode
  = ProgressCode String
```

A token representing the state of the job, such as "Started".

#### `ProgressMessage`

``` purescript
newtype ProgressMessage
  = ProgressMessage String
```

A more human readable form of the job status.

#### `Signature`

``` purescript
newtype Signature
  = Signature String
```

An encrypted code used to authenticate the request and response, for example, "DV+TpDfx1/TdSE9ktyK9k/bDTVI=". Only use this value is you want to create the signature file yourself. Generally you should use the SignatureFileContents value.

#### `SignatureFileContents`

``` purescript
newtype SignatureFileContents
  = SignatureFileContents String
```

The actual text of the SIGNATURE file to be written to disk.

#### `Success`

``` purescript
newtype Success
  = Success Boolean
```

Specifies whether (true) or not (false) AWS Import/Export updated your job.

#### `TrackingNumber`

``` purescript
newtype TrackingNumber
  = TrackingNumber String
```

The shipping tracking number assigned by AWS Import/Export to the storage device when it's returned to you. We return this value when the LocationCode is "Returned".

#### `URL`

``` purescript
newtype URL
  = URL String
```

The URL for a given Artifact.

#### `UnableToCancelJobIdException`

``` purescript
newtype UnableToCancelJobIdException
  = UnableToCancelJobIdException { "Message'" :: NullOrUndefined (ErrorMessage) }
```

AWS Import/Export cannot cancel the job

#### `UnableToUpdateJobIdException`

``` purescript
newtype UnableToUpdateJobIdException
  = UnableToUpdateJobIdException { "Message'" :: NullOrUndefined (ErrorMessage) }
```

AWS Import/Export cannot update the job

#### `UpdateJobInput`

``` purescript
newtype UpdateJobInput
  = UpdateJobInput { "JobId" :: JobId, "Manifest" :: Manifest, "JobType" :: JobType, "ValidateOnly" :: ValidateOnly, "APIVersion" :: NullOrUndefined (APIVersion) }
```

Input structure for the UpateJob operation.

#### `UpdateJobOutput`

``` purescript
newtype UpdateJobOutput
  = UpdateJobOutput { "Success" :: NullOrUndefined (Success), "WarningMessage" :: NullOrUndefined (WarningMessage), "ArtifactList" :: NullOrUndefined (ArtifactList) }
```

Output structure for the UpateJob operation.

#### `ValidateOnly`

``` purescript
newtype ValidateOnly
  = ValidateOnly Boolean
```

Validate the manifest and parameter values in the request but do not actually create a job.

#### `WarningMessage`

``` purescript
newtype WarningMessage
  = WarningMessage String
```

An optional message notifying you of non-fatal issues with the job, such as use of an incompatible Amazon S3 bucket name.

#### `City'`

``` purescript
newtype City'
  = City' String
```

Specifies the name of your city for the return address.

#### `Company'`

``` purescript
newtype Company'
  = Company' String
```

Specifies the name of the company that will ship this package.

#### `Country'`

``` purescript
newtype Country'
  = Country' String
```

Specifies the name of your country for the return address.

#### `Name'`

``` purescript
newtype Name'
  = Name' String
```

Specifies the name of the person responsible for shipping this package.

#### `PhoneNumber'`

``` purescript
newtype PhoneNumber'
  = PhoneNumber' String
```

Specifies the phone number of the person responsible for shipping this package.

#### `PostalCode'`

``` purescript
newtype PostalCode'
  = PostalCode' String
```

Specifies the postal code for the return address.

#### `StateOrProvince'`

``` purescript
newtype StateOrProvince'
  = StateOrProvince' String
```

Specifies the name of your state or your province for the return address.

#### `Street1'`

``` purescript
newtype Street1'
  = Street1' String
```

Specifies the first part of the street address for the return address, for example 1234 Main Street.

#### `Street2'`

``` purescript
newtype Street2'
  = Street2' String
```

Specifies the optional second part of the street address for the return address, for example Suite 100.

#### `Street3'`

``` purescript
newtype Street3'
  = Street3' String
```

Specifies the optional third part of the street address for the return address, for example c/o Jane Doe.

