<#import "field.ftl" as field>
<#macro userProfileFormFields>
	<#assign attributes=profile.attributes >

	<@field.group name=attributes[0].name label=advancedMsg(attributes[0].displayName!'') error=kcSanitize(messagesPerField.get('${attributes[0].name}'))?no_esc required=attributes[0].required>
		<div class="${properties.kcInputWrapperClass!}">
			<#if attributes[0].annotations.inputHelperTextBefore??>
				<div class="${properties.kcInputHelperTextBeforeClass!}" id="form-help-text-before-${attribute.name}" aria-live="polite">${kcSanitize(advancedMsg(attribute.annotations.inputHelperTextBefore))?no_esc}</div>
			</#if>
			<@inputFieldByType attribute=attributes[0]/>
			<#if attributes[0].annotations.inputHelperTextAfter??>
				<div class="${properties.kcInputHelperTextAfterClass!}" id="form-help-text-after-${attributes[0].name}" aria-live="polite">${kcSanitize(advancedMsg(attributes[0].annotations.inputHelperTextAfter))?no_esc}</div>
			</#if>
		</div>
	</@field.group>
	<@field.group name=attributes[1].name label=advancedMsg(attributes[1].displayName!'') error=kcSanitize(messagesPerField.get('${attributes[1].name}'))?no_esc required=attributes[1].required>
		<div class="${properties.kcInputWrapperClass!}">
			<#if attributes[1].annotations.inputHelperTextBefore??>
				<div class="${properties.kcInputHelperTextBeforeClass!}" id="form-help-text-before-${attribute.name}" aria-live="polite">${kcSanitize(advancedMsg(attribute.annotations.inputHelperTextBefore))?no_esc}</div>
			</#if>
			<@inputFieldByType attribute=attributes[1]/>
			<#if attributes[1].annotations.inputHelperTextAfter??>
				<div class="${properties.kcInputHelperTextAfterClass!}" id="form-help-text-after-${attributes[1].name}" aria-live="polite">${kcSanitize(advancedMsg(attributes[1].annotations.inputHelperTextAfter))?no_esc}</div>
			</#if>
		</div>
	</@field.group>
	<div class="grid lg:grid-cols-2 gap-4">
		<@field.group name=attributes[2].name label=advancedMsg(attributes[2].displayName!'') error=kcSanitize(messagesPerField.get('${attributes[2].name}'))?no_esc required=attributes[2].required>
			<div class="${properties.kcInputWrapperClass!}">
				<#if attributes[2].annotations.inputHelperTextBefore??>
					<div class="${properties.kcInputHelperTextBeforeClass!}" id="form-help-text-before-${attribute.name}" aria-live="polite">${kcSanitize(advancedMsg(attribute.annotations.inputHelperTextBefore))?no_esc}</div>
				</#if>
				<@inputFieldByType attribute=attributes[2]/>
				<#if attributes[2].annotations.inputHelperTextAfter??>
					<div class="${properties.kcInputHelperTextAfterClass!}" id="form-help-text-after-${attributes[2].name}" aria-live="polite">${kcSanitize(advancedMsg(attributes[2].annotations.inputHelperTextAfter))?no_esc}</div>
				</#if>
			</div>
		</@field.group>
		<@field.group name=attributes[3].name label=advancedMsg(attributes[3].displayName!'') error=kcSanitize(messagesPerField.get('${attributes[3].name}'))?no_esc required=attributes[3].required>
			<div class="${properties.kcInputWrapperClass!}">
				<#if attributes[3].annotations.inputHelperTextBefore??>
					<div class="${properties.kcInputHelperTextBeforeClass!}" id="form-help-text-before-${attribute.name}" aria-live="polite">${kcSanitize(advancedMsg(attribute.annotations.inputHelperTextBefore))?no_esc}</div>
				</#if>
				<@inputFieldByType attribute=attributes[3]/>
				<#if attributes[3].annotations.inputHelperTextAfter??>
					<div class="${properties.kcInputHelperTextAfterClass!}" id="form-help-text-after-${attributes[3].name}" aria-live="polite">${kcSanitize(advancedMsg(attributes[3].annotations.inputHelperTextAfter))?no_esc}</div>
				</#if>
			</div>
		</@field.group>
	</div>

	<#--  Showing Field Password and Confirm Password  -->
	<#nested "beforeField" attributes[0]>
	<#nested "afterField" attributes[1]>

	<#list profile.html5DataAnnotations?keys as key>
        <script type="module" src="${url.resourcesPath}/js/${key}.js"></script>
    </#list>
</#macro>

<#macro inputFieldByType attribute>
	<#switch attribute.annotations.inputType!''>
	<#case 'textarea'>
		<@textareaTag attribute=attribute/>
		<#break>
	<#case 'select'>
	<#case 'multiselect'>
		<@selectTag attribute=attribute/>
		<#break>
	<#case 'select-radiobuttons'>
	<#case 'multiselect-checkboxes'>
		<@inputTagSelects attribute=attribute/>
		<#break>
	<#default>
		<#if attribute.multivalued && attribute.values?has_content>
			<#list attribute.values as value>
				<@inputTag attribute=attribute value=value!''/>
			</#list>
		<#else>
			<@inputTag attribute=attribute value=attribute.value!''/>
		</#if>
	</#switch>
</#macro>

<#macro inputTag attribute value>
	<span class="<#if error?has_content>${properties.kcError}</#if>">
		<input type="<@inputTagType attribute=attribute/>" id="${attribute.name}" name="${attribute.name}" value="${(value!'')}" 
			class="px-4 py-2.5 bg-white text-gray-800 rounded-lg border border-gray-300 focus:outline-none focus:border-purple-300 focus:border-dashed focus:ring-1 focus:ring-offset-2 focus:ring-purple-500 w-full"
			aria-invalid="<#if messagesPerField.existsError('${attribute.name}')>true</#if>"
			<#if attribute.readOnly>disabled</#if>
			<#if attribute.autocomplete??>autocomplete="${attribute.autocomplete}"</#if>
			<#if attribute.annotations.inputTypePlaceholder??>placeholder="${advancedMsg(attribute.annotations.inputTypePlaceholder)}"</#if>
			<#if attribute.annotations.inputTypePattern??>pattern="${attribute.annotations.inputTypePattern}"</#if>
			<#if attribute.annotations.inputTypeSize??>size="${attribute.annotations.inputTypeSize}"</#if>
			<#if attribute.annotations.inputTypeMaxlength??>maxlength="${attribute.annotations.inputTypeMaxlength}"</#if>
			<#if attribute.annotations.inputTypeMinlength??>minlength="${attribute.annotations.inputTypeMinlength}"</#if>
			<#if attribute.annotations.inputTypeMax??>max="${attribute.annotations.inputTypeMax}"</#if>
			<#if attribute.annotations.inputTypeMin??>min="${attribute.annotations.inputTypeMin}"</#if>
			<#if attribute.annotations.inputTypeStep??>step="${attribute.annotations.inputTypeStep}"</#if>
			<#if attribute.annotations.inputTypeStep??>step="${attribute.annotations.inputTypeStep}"</#if>
			<#list attribute.html5DataAnnotations as key, value>
					data-${key}="${value}"
			</#list>
		/>
	</span>
</#macro>

<#macro inputTagType attribute>
	<#compress>
	<#if attribute.annotations.inputType??>
		<#if attribute.annotations.inputType?starts_with("html5-")>
			${attribute.annotations.inputType[6..]}
		<#else>
			${attribute.annotations.inputType}
		</#if>
	<#else>
	text
	</#if>
	</#compress>
</#macro>

<#macro textareaTag attribute>
	<textarea id="${attribute.name}" name="${attribute.name}" class="${properties.kcInputClass!}"
		aria-invalid="<#if messagesPerField.existsError('${attribute.name}')>true</#if>"
		<#if attribute.readOnly>disabled</#if>
		<#if attribute.annotations.inputTypeCols??>cols="${attribute.annotations.inputTypeCols}"</#if>
		<#if attribute.annotations.inputTypeRows??>rows="${attribute.annotations.inputTypeRows}"</#if>
		<#if attribute.annotations.inputTypeMaxlength??>maxlength="${attribute.annotations.inputTypeMaxlength}"</#if>
	>${(attribute.value!'')}</textarea>
</#macro>

<#macro selectTag attribute>
	<div class="${properties.kcInputClass!}">
		<select id="${attribute.name}" name="${attribute.name}"
			aria-invalid="<#if messagesPerField.existsError('${attribute.name}')>true</#if>"
			<#if attribute.readOnly>disabled</#if>
			<#if attribute.annotations.inputType=='multiselect'>multiple</#if>
			<#if attribute.annotations.inputTypeSize??>size="${attribute.annotations.inputTypeSize}"</#if>
		>
			<#if attribute.annotations.inputType=='select'>
				<option value=""></option>
			</#if>

			<#if attribute.annotations.inputOptionsFromValidation?? && attribute.validators[attribute.annotations.inputOptionsFromValidation]?? && attribute.validators[attribute.annotations.inputOptionsFromValidation].options??>
				<#assign options=attribute.validators[attribute.annotations.inputOptionsFromValidation].options>
			<#elseif attribute.validators.options?? && attribute.validators.options.options??>
				<#assign options=attribute.validators.options.options>
			<#else>
				<#assign options=[]>
			</#if>

			<#list options as option>
				<option value="${option}" <#if attribute.values?seq_contains(option)>selected</#if>><@selectOptionLabelText attribute=attribute option=option/></option>
			</#list>
		</select>
		<span class="${properties.kcFormControlUtilClass}">
			<span class="${properties.kcFormControlToggleIcon!}">
				<svg
					class="pf-v5-svg"
					viewBox="0 0 320 512"
					fill="currentColor"
					aria-hidden="true"
					role="img"
					width="1em"
					height="1em"
				>
					<path
						d="M31.3 192h257.3c17.8 0 26.7 21.5 14.1 34.1L174.1 354.8c-7.8 7.8-20.5 7.8-28.3 0L17.2 226.1C4.6 213.5 13.5 192 31.3 192z"
					>
					</path>
				</svg>
			</span>
		</span>
	</div>
</#macro>

<#macro inputTagSelects attribute>
	<#if attribute.annotations.inputType=='select-radiobuttons'>
		<#assign inputType='radio'>
		<#assign classDiv=properties.kcInputClassRadio!>
		<#assign classInput=properties.kcInputClassRadioInput!>
		<#assign classLabel=properties.kcInputClassRadioLabel!>
	<#else>	
		<#assign inputType='checkbox'>
		<#assign classDiv=properties.kcInputClassCheckbox!>
		<#assign classInput=properties.kcInputClassCheckboxInput!>
		<#assign classLabel=properties.kcInputClassCheckboxLabel!>
	</#if>
	
	<#if attribute.annotations.inputOptionsFromValidation?? && attribute.validators[attribute.annotations.inputOptionsFromValidation]?? && attribute.validators[attribute.annotations.inputOptionsFromValidation].options??>
        <#assign options=attribute.validators[attribute.annotations.inputOptionsFromValidation].options>
    <#elseif attribute.validators.options?? && attribute.validators.options.options??>
        <#assign options=attribute.validators.options.options>
    <#else>
        <#assign options=[]>
    </#if>

    <#list options as option>
        <div class="${classDiv}">
            <input type="${inputType}" id="${attribute.name}-${option}" name="${attribute.name}" value="${option}" class="${classInput}"
                aria-invalid="<#if messagesPerField.existsError('${attribute.name}')>true</#if>"
                <#if attribute.readOnly>disabled</#if>
                <#if attribute.values?seq_contains(option)>checked</#if>
            />
            <label for="${attribute.name}-${option}" class="${classLabel}<#if attribute.readOnly> ${properties.kcInputClassRadioCheckboxLabelDisabled!}</#if>"><@selectOptionLabelText attribute=attribute option=option/></label>
        </div>
    </#list>
</#macro>

<#macro selectOptionLabelText attribute option>
	<#compress>
	<#if attribute.annotations.inputOptionLabels??>
		${advancedMsg(attribute.annotations.inputOptionLabels[option]!option)}
	<#else>
		<#if attribute.annotations.inputOptionLabelsI18nPrefix??>
			${msg(attribute.annotations.inputOptionLabelsI18nPrefix + '.' + option)}
		<#else>
			${option}
		</#if>
	</#if>
	</#compress>
</#macro>
