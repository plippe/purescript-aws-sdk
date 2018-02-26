

-- | <p>The Cost Explorer API allows you to programmatically query your cost and usage data. You can query for aggregated data such as total monthly costs or total daily usage. You can also query for granular data, such as the number of daily write operations for DynamoDB database tables in your production environment. </p> <p>Service Endpoint</p> <p>The Cost Explorer API provides the following endpoint:</p> <ul> <li> <p>https://ce.us-east-1.amazonaws.com</p> </li> </ul>
module AWS.CostExplorer where

import Control.Monad.Aff (Aff)
import Data.Foreign.NullOrUndefined (NullOrUndefined)
import Data.Map (Map)
import Data.Unit (Unit, unit)

import AWS.Request as AWS

serviceName = "CostExplorer" :: String


-- | <p>Retrieve cost and usage metrics for your account. You can specify which cost and usage-related metric, such as <code>BlendedCosts</code> or <code>UsageQuantity</code>, that you want the request to return. You can also filter and group your data by various dimensions, such as <code>SERVICE</code> or <code>AZ</code>, in a specific time range. See the <code>GetDimensionValues</code> action for a complete list of the valid dimensions. Master accounts in an organization have access to all member accounts.</p>
getCostAndUsage :: forall eff. GetCostAndUsageRequest -> Aff (err :: AWS.RequestError | eff) GetCostAndUsageResponse
getCostAndUsage = AWS.request serviceName "GetCostAndUsage" 


-- | <p>You can use <code>GetDimensionValues</code> to retrieve all available filter values for a specific filter over a period of time. You can search the dimension values for an arbitrary string. </p>
getDimensionValues :: forall eff. GetDimensionValuesRequest -> Aff (err :: AWS.RequestError | eff) GetDimensionValuesResponse
getDimensionValues = AWS.request serviceName "GetDimensionValues" 


-- | <p>Retrieve the reservation coverage for your account. An organization's master account has access to the associated member accounts. For any time period, you can filter data about reservation usage by the following dimensions. </p> <ul> <li> <p>AZ</p> </li> <li> <p>INSTANCE_TYPE</p> </li> <li> <p>LINKED_ACCOUNT</p> </li> <li> <p>PLATFORM</p> </li> <li> <p>REGION</p> </li> <li> <p>TENANCY</p> </li> </ul> <p>To determine valid values for a dimension, use the <code>GetDimensionValues</code> operation. </p>
getReservationCoverage :: forall eff. GetReservationCoverageRequest -> Aff (err :: AWS.RequestError | eff) GetReservationCoverageResponse
getReservationCoverage = AWS.request serviceName "GetReservationCoverage" 


-- | <p>You can retrieve the Reservation utilization for your account. Master accounts in an organization have access to their associated member accounts. You can filter data by dimensions in a time period. You can use <code>GetDimensionValues</code> to determine the possible dimension values. Currently, you can group only by <code>SUBSCRIPTION_ID</code>. </p>
getReservationUtilization :: forall eff. GetReservationUtilizationRequest -> Aff (err :: AWS.RequestError | eff) GetReservationUtilizationResponse
getReservationUtilization = AWS.request serviceName "GetReservationUtilization" 


-- | <p>You can query for available tag keys and tag values for a specified period. You can search the tag values for an arbitrary string. </p>
getTags :: forall eff. GetTagsRequest -> Aff (err :: AWS.RequestError | eff) GetTagsResponse
getTags = AWS.request serviceName "GetTags" 


newtype AttributeType = AttributeType String


newtype AttributeValue = AttributeValue String


newtype Attributes = Attributes (Map AttributeType AttributeValue)


-- | <p>The requested report expired. Update the date interval and try again.</p>
newtype BillExpirationException = BillExpirationException 
  { "Message" :: NullOrUndefined (ErrorMessage)
  }


newtype Context = Context String


-- | <p>The amount of instance usage that a reservation covered.</p>
newtype Coverage = Coverage 
  { "CoverageHours" :: NullOrUndefined (CoverageHours)
  }


-- | <p>Reservation coverage, in hours.</p>
newtype CoverageByTime = CoverageByTime 
  { "TimePeriod" :: NullOrUndefined (DateInterval)
  , "Groups" :: NullOrUndefined (ReservationCoverageGroups)
  , "Total" :: NullOrUndefined (Coverage)
  }


-- | <p>How long a running instance either used a reservation or was On-Demand.</p>
newtype CoverageHours = CoverageHours 
  { "OnDemandHours" :: NullOrUndefined (OnDemandHours)
  , "ReservedHours" :: NullOrUndefined (ReservedHours)
  , "TotalRunningHours" :: NullOrUndefined (TotalRunningHours)
  , "CoverageHoursPercentage" :: NullOrUndefined (CoverageHoursPercentage)
  }


newtype CoverageHoursPercentage = CoverageHoursPercentage String


newtype CoveragesByTime = CoveragesByTime (Array CoverageByTime)


-- | <p>The requested data is unavailable.</p>
newtype DataUnavailableException = DataUnavailableException 
  { "Message" :: NullOrUndefined (ErrorMessage)
  }


-- | <p>The time period that you want the usage and costs for. </p>
newtype DateInterval = DateInterval 
  { "Start" :: (YearMonthDay)
  , "End" :: (YearMonthDay)
  }


newtype Dimension = Dimension String


-- | <p>The metadata that you can use to filter and group your results. You can use <code>GetDimensionValues</code> to find specific values.</p>
newtype DimensionValues = DimensionValues 
  { "Key" :: NullOrUndefined (Dimension)
  , "Values" :: NullOrUndefined (Values)
  }


-- | <p>The metadata of a specific type that you can use to filter and group your results. You can use <code>GetDimensionValues</code> to find specific values.</p>
newtype DimensionValuesWithAttributes = DimensionValuesWithAttributes 
  { "Value" :: NullOrUndefined (Value)
  , "Attributes" :: NullOrUndefined (Attributes)
  }


newtype DimensionValuesWithAttributesList = DimensionValuesWithAttributesList (Array DimensionValuesWithAttributes)


newtype Entity = Entity String


newtype ErrorMessage = ErrorMessage String


newtype Estimated = Estimated Boolean


-- | <p>Use <code>Expression</code> to filter by cost or by usage. There are two patterns: </p> <ul> <li> <p>Simple dimension values - You can set the dimension name and values for the filters that you plan to use. For example, you can filter for <code>INSTANCE_TYPE==m4.xlarge OR INSTANCE_TYPE==c4.large</code>. The <code>Expression</code> for that looks like this.</p> <p> <code>{ "Dimensions": { "Key": "INSTANCE_TYPE", "Values": [ "m4.xlarge", “c4.large” ] } }</code> </p> <p>The list of dimension values are OR'd together to retrieve cost or usage data. You can create <code>Expression</code> and <code>DimensionValues</code> objects using either <code>with*</code> methods or <code>set*</code> methods in multiple lines. </p> </li> <li> <p>Compound dimension values with logical operations - You can use multiple <code>Expression</code> types and the logical operators <code>AND/OR/NOT</code> to create a list of one or more <code>Expression</code> objects. This allows you to filter on more advanced options. For example, you can filter on <code>((INSTANCE_TYPE == m4.large OR INSTANCE_TYPE == m3.large) OR (TAG.Type == Type1)) AND (USAGE_TYPE != DataTransfer)</code>. The <code>Expression</code> for that looks like this.</p> <p> <code>{ "And": [ {"Or": [ {"Dimensions": { "Key": "INSTANCE_TYPE", "Values": [ "m4.x.large", "c4.large" ] }}, {"Tag": { "Key": "TagName", "Values": ["Value1"] } } ]}, {"Not": {"dimensions": { "Key": "USAGE_TYPE", "Values": ["DataTransfer"] }}} ] } </code> </p> <note> <p>Because each <code>Expression</code> can have only one operator, the service returns an error if more than one is specified. The following example shows an Expression object that will create an error.</p> </note> <p> <code> { "And": [ ... ], "DimensionValues": { "Dimension": "USAGE_TYPE", "Values": [ "DataTransfer" ] } } </code> </p> </li> </ul>
newtype Expression = Expression 
  { "Or" :: NullOrUndefined (Expressions)
  , "And" :: NullOrUndefined (Expressions)
  , "Not" :: NullOrUndefined (Expression)
  , "Dimensions" :: NullOrUndefined (DimensionValues)
  , "Tags" :: NullOrUndefined (TagValues)
  }


newtype Expressions = Expressions (Array Expression)


newtype GetCostAndUsageRequest = GetCostAndUsageRequest 
  { "TimePeriod" :: NullOrUndefined (DateInterval)
  , "Granularity" :: NullOrUndefined (Granularity)
  , "Filter" :: NullOrUndefined (Expression)
  , "Metrics" :: NullOrUndefined (MetricNames)
  , "GroupBy" :: NullOrUndefined (GroupDefinitions)
  , "NextPageToken" :: NullOrUndefined (NextPageToken)
  }


newtype GetCostAndUsageResponse = GetCostAndUsageResponse 
  { "NextPageToken" :: NullOrUndefined (NextPageToken)
  , "GroupDefinitions" :: NullOrUndefined (GroupDefinitions)
  , "ResultsByTime" :: NullOrUndefined (ResultsByTime)
  }


newtype GetDimensionValuesRequest = GetDimensionValuesRequest 
  { "SearchString" :: NullOrUndefined (SearchString)
  , "TimePeriod" :: (DateInterval)
  , "Dimension" :: (Dimension)
  , "Context" :: NullOrUndefined (Context)
  , "NextPageToken" :: NullOrUndefined (NextPageToken)
  }


newtype GetDimensionValuesResponse = GetDimensionValuesResponse 
  { "DimensionValues" :: (DimensionValuesWithAttributesList)
  , "ReturnSize" :: (PageSize)
  , "TotalSize" :: (PageSize)
  , "NextPageToken" :: NullOrUndefined (NextPageToken)
  }


-- | <p>You can query for how much of your instance usage was covered by a reservation.</p>
newtype GetReservationCoverageRequest = GetReservationCoverageRequest 
  { "TimePeriod" :: (DateInterval)
  , "GroupBy" :: NullOrUndefined (GroupDefinitions)
  , "Granularity" :: NullOrUndefined (Granularity)
  , "Filter" :: NullOrUndefined (Expression)
  , "NextPageToken" :: NullOrUndefined (NextPageToken)
  }


newtype GetReservationCoverageResponse = GetReservationCoverageResponse 
  { "CoveragesByTime" :: (CoveragesByTime)
  , "Total" :: NullOrUndefined (Coverage)
  , "NextPageToken" :: NullOrUndefined (NextPageToken)
  }


newtype GetReservationUtilizationRequest = GetReservationUtilizationRequest 
  { "TimePeriod" :: (DateInterval)
  , "GroupBy" :: NullOrUndefined (GroupDefinitions)
  , "Granularity" :: NullOrUndefined (Granularity)
  , "Filter" :: NullOrUndefined (Expression)
  , "NextPageToken" :: NullOrUndefined (NextPageToken)
  }


newtype GetReservationUtilizationResponse = GetReservationUtilizationResponse 
  { "UtilizationsByTime" :: (UtilizationsByTime)
  , "Total" :: NullOrUndefined (ReservationAggregates)
  , "NextPageToken" :: NullOrUndefined (NextPageToken)
  }


newtype GetTagsRequest = GetTagsRequest 
  { "SearchString" :: NullOrUndefined (SearchString)
  , "TimePeriod" :: (DateInterval)
  , "TagKey" :: NullOrUndefined (TagKey)
  , "NextPageToken" :: NullOrUndefined (NextPageToken)
  }


newtype GetTagsResponse = GetTagsResponse 
  { "NextPageToken" :: NullOrUndefined (NextPageToken)
  , "Tags" :: (TagList)
  , "ReturnSize" :: (PageSize)
  , "TotalSize" :: (PageSize)
  }


newtype Granularity = Granularity String


-- | <p>One level of grouped data within the results.</p>
newtype Group = Group 
  { "Keys" :: NullOrUndefined (Keys)
  , "Metrics" :: NullOrUndefined (Metrics)
  }


-- | <p>Represents a group when you specify a group by criteria, or in the response to a query with a specific grouping.</p>
newtype GroupDefinition = GroupDefinition 
  { "Type" :: NullOrUndefined (GroupDefinitionType)
  , "Key" :: NullOrUndefined (GroupDefinitionKey)
  }


newtype GroupDefinitionKey = GroupDefinitionKey String


newtype GroupDefinitionType = GroupDefinitionType String


newtype GroupDefinitions = GroupDefinitions (Array GroupDefinition)


newtype Groups = Groups (Array Group)


-- | <p>The pagination token is invalid. Try again without a pagination token.</p>
newtype InvalidNextTokenException = InvalidNextTokenException 
  { "Message" :: NullOrUndefined (ErrorMessage)
  }


newtype Key = Key String


newtype Keys = Keys (Array Key)


-- | <p>You made too many calls in a short period of time. Try again later.</p>
newtype LimitExceededException = LimitExceededException 
  { "Message" :: NullOrUndefined (ErrorMessage)
  }


newtype MetricAmount = MetricAmount String


newtype MetricName = MetricName String


newtype MetricNames = MetricNames (Array MetricName)


newtype MetricUnit = MetricUnit String


-- | <p>The aggregated value for a metric.</p>
newtype MetricValue = MetricValue 
  { "Amount" :: NullOrUndefined (MetricAmount)
  , "Unit''" :: NullOrUndefined (MetricUnit)
  }


newtype Metrics = Metrics (Map MetricName MetricValue)


newtype NextPageToken = NextPageToken String


newtype OnDemandHours = OnDemandHours String


newtype PageSize = PageSize Int


newtype PurchasedHours = PurchasedHours String


-- | <p>The aggregated numbers for your RI usage.</p>
newtype ReservationAggregates = ReservationAggregates 
  { "UtilizationPercentage" :: NullOrUndefined (UtilizationPercentage)
  , "PurchasedHours" :: NullOrUndefined (PurchasedHours)
  , "TotalActualHours" :: NullOrUndefined (TotalActualHours)
  , "UnusedHours" :: NullOrUndefined (UnusedHours)
  }


-- | <p>A group of reservations that share a set of attributes.</p>
newtype ReservationCoverageGroup = ReservationCoverageGroup 
  { "Attributes" :: NullOrUndefined (Attributes)
  , "Coverage" :: NullOrUndefined (Coverage)
  }


newtype ReservationCoverageGroups = ReservationCoverageGroups (Array ReservationCoverageGroup)


newtype ReservationGroupKey = ReservationGroupKey String


newtype ReservationGroupValue = ReservationGroupValue String


-- | <p>A group of RIs that share a set of attributes.</p>
newtype ReservationUtilizationGroup = ReservationUtilizationGroup 
  { "Key" :: NullOrUndefined (ReservationGroupKey)
  , "Value" :: NullOrUndefined (ReservationGroupValue)
  , "Attributes" :: NullOrUndefined (Attributes)
  , "Utilization" :: NullOrUndefined (ReservationAggregates)
  }


newtype ReservationUtilizationGroups = ReservationUtilizationGroups (Array ReservationUtilizationGroup)


newtype ReservedHours = ReservedHours String


-- | <p>The result that is associated with a time period.</p>
newtype ResultByTime = ResultByTime 
  { "TimePeriod" :: NullOrUndefined (DateInterval)
  , "Total" :: NullOrUndefined (Metrics)
  , "Groups" :: NullOrUndefined (Groups)
  , "Estimated" :: NullOrUndefined (Estimated)
  }


newtype ResultsByTime = ResultsByTime (Array ResultByTime)


newtype SearchString = SearchString String


newtype TagKey = TagKey String


newtype TagList = TagList (Array Entity)


-- | <p>The values that are available for a tag.</p>
newtype TagValues = TagValues 
  { "Key" :: NullOrUndefined (TagKey)
  , "Values" :: NullOrUndefined (Values)
  }


newtype TotalActualHours = TotalActualHours String


newtype TotalRunningHours = TotalRunningHours String


newtype UnusedHours = UnusedHours String


-- | <p>The amount of utilization, in hours.</p>
newtype UtilizationByTime = UtilizationByTime 
  { "TimePeriod" :: NullOrUndefined (DateInterval)
  , "Groups" :: NullOrUndefined (ReservationUtilizationGroups)
  , "Total" :: NullOrUndefined (ReservationAggregates)
  }


newtype UtilizationPercentage = UtilizationPercentage String


newtype UtilizationsByTime = UtilizationsByTime (Array UtilizationByTime)


newtype Value = Value String


newtype Values = Values (Array Value)


newtype YearMonthDay = YearMonthDay String